class GistBlob
  include ActiveModel::Validations

  attr_accessor :blob, :name#, :description

  validates :blob, { presence: true }

  def self.from_params(params)
    new.tap do |gf|
      params.keys.each do |k|
        gf.send("#{k}=", params[k])
      end
    end
  end
end
