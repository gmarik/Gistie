class GistFile
  include ActiveModel::Validations

  attr_accessor :contents, :name#, :description

  validates :contents, { presence: true }

  def self.from_params(params)
    new.tap do |gf|
      params.keys.each do |k|
        gf.send("#{k}=", params[k])
      end
    end
  end
end
