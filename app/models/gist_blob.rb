class GistBlob
  include ActiveModel::Validations

  attr_accessor :blob, :name#, :description

  validates :blob, { presence: true }

  def initialize(params = {})
    params.each do |k, v|
      self.send("#{k}=", v)
    end
  end

  def name
    @name || 'Text'
  end

  def blank?
    self.blob.blank?
  end
end
