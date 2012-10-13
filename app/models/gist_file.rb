class GistBlob
  include ActiveModel::Validations

  VALID_ATTRS= [
    :name,
    :blob
  ]

  attr_accessor *VALID_ATTRS

  validates :blob, { presence: true }

  # since it's not an ActiveRecord
  # TODO: does ActiveModel have smth for this
  def self.from_params(params)
    new.tap do |gb|
      params.slice(*VALID_ATTRS).each do |k, v|
        gb.send("#{k}=", v)
      end
    end
  end
end
