class Gist < ActiveRecord::Base

  # TODO: rename this to gist_files instead gist_blobs
  # as blob is just content without filename
  attr_accessor :gist_blobs, :gist_blobs_attributes

  attr_accessible :gist_blobs_attributes

  validate :non_blank, :unique_names

  def non_blank
    blank? and errors.add(:gist_blobs, "Can't be blank")
  end

  def unique_names
    uniq = (gist_blobs.size == gist_blobs.map(&:name).uniq.size)
    uniq or errors.add(:gist_blobs, "Duplicate names")
  end

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

  def save_and_commit!(update_attrs = {})
    SaveGist.new(self).(update_attrs)
  end

  def repo_path(root = Rails.root)
    root + 'repos/' + (self.id.to_s + ".git")
  end

  def repo
    if new_record? then nil
    else @repo ||= GistRepo.new(repo_path.to_s)
    end
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
end
