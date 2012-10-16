class Gist < ActiveRecord::Base
  include GitRepo
  include GistReader

  # TODO: rename this to gist_files instead gist_blobs
  # as blob is just content without filename
  attr_accessor :gist_blobs, :gist_blobs_attributes

  attr_accessible :gist_blobs_attributes

  validate :non_blank, :unique_names

  def non_blank
    blank? and errors.add(:gist_blobs, "Can't be blank")
  end

  def gist_blobs_attributes
    @gist_blobs_attributes || []
  end

  def gist_blobs
    @gist_blobs ||= begin
       if new_record? then []
       else gist_read
       end
    end
  end

  def gist_read
    repo_read.map do |params|
      GistBlob.from_params(entry)
    end
  end

  def unique_names
    uniq = (gist_blobs.size == gist_blobs.map(&:name).uniq.size)
    uniq or errors.add(:gist_blobs, "Duplicate names")
  end

  def blank?
    gist_blobs.blank?
  end

  def gist_blobs_attributes=(attrs)
    self.gist_blobs = attrs.map do |attr|
      GistBlob.from_params(attr)
    end.reject(&:blank?)
  end
end
