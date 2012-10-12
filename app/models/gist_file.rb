class GistFile
  include ActiveModel::Validations

  attr_accessor :contents, :name#, :description

  validates :contents, { presence: true }
end
