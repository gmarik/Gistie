class Gist < ActiveRecord::Base
  include GitRepo

  attr_accessor :gist_blobs, :gist_blobs_attributes

  attr_accessible :gist_blobs_attributes

  validate :non_blank

  def non_blank
    blank? and errors.add(:blob, "Can't be blank")
  end

  def blank?
    gist_blobs.blank?
  end

  def gist_blobs_attributes=(attrs)
    self.gist_blobs = attrs.map do |attr|
      GistBlob.from_params(attr)
    end
  end
end
