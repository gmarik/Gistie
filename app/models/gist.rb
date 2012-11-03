class Gist < ActiveRecord::Base

  # TODO: rename this to gist_files instead gist_blobs
  # as blob is just content without filename
  attr_accessor :gist_blobs, :gist_blobs_attributes

  attr_accessible :gist_blobs_attributes, :description

  validate :non_blank, :unique_names

  def non_blank
    blank? and errors.add(:gist_blobs, "Can't be blank")
  end

  def unique_names
    dups = dup_names(gist_blobs).map {|name, count| %Q["#{name}": #{count}] }
    dups.empty? or
      errors.add(:gist_blobs, "duplicate names: #{dups.join(',')}")
  end

  def dup_names(blobs)
    duplicates = blobs.map(&:name).
      group_by {|b| b }.
      values.
      map {|b| [b.first, b.size]}.
      select {|name, count| count > 1}
  end

  private :dup_names

  def blank?
    gist_blobs.blank?
  end


  def gist_blobs_attributes
    @gist_blobs_attributes || []
  end

  def gist_blobs_attributes=(attrs)
    self.gist_blobs = attrs.map do |attr|
      GistBlob.from_params(attr)
    end.reject(&:blank?)
  end

  # Git integration
  def gist_blobs
    @gist_blobs ||= begin
       if new_record? then []
       else gist_read
       end
    end
  end

  def save_and_commit(*args)
    begin
      save_and_commit!(*args) 
      true
    rescue ActiveRecord::RecordInvalid => e
      # TODO: log e
      false
    end
  end

  def save_and_commit!(update_attrs = {})
    SaveGist.new(self).(update_attrs)
  end

  def repo_name
    id.to_s
  end

  def repo
    if new_record? then nil
    else @repo ||= GistRepo.named(repo_name)
    end
  end

  def init_repo
    GistRepo.init_named_repo(repo_name)
  end

  def gist_read
    repo.repo_read.map(&method(:gist_blob))
  end

  def gist_blob(entry)
    # TODO: make consitent
    params = {name: entry[:name], blob: entry[:content]}
    GistBlob.from_params(params)
  end

  def gist_write
    repo.write(self.gist_blobs)
  end

  def to_preview_html
    self.gist_blobs.first.to_formatted_html(true)
  end
end
