class Gist #< ActiveRecord::Base
  include ActiveModel::Validations

  # has_many :gist_files
  # belongs_to :gist_repository


  validate :non_empty

  def non_empty
    errors.add(:contents, "Can't be empty")
  end
end
