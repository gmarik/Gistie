class Gist #< ActiveRecord::Base
  include ActiveModel::Validations

  # has_many :gist_files
  # belongs_to :gist_repository

  validate :non_blank

  def non_blank
    blank? and errors.add(:contents, "Can't be blank")
  end

  def blank?
    true
  end
end
