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

  def name
    @name || 'Text'
  end

  def blob
    if @blob.respond_to?(:call) then @blob.call
    else @blob
    end
  end

  def blank?
    self.blob.blank?
  end

  # TODO: rename to something more meaningful
  def to_formatted_html(excerpt = false, limit = 4)

    _blob = if excerpt
      blob.split("\n").take(limit).join("\n")
    else
      blob
    end

    HighlightedSource.new(name, _blob).to_formatted_html.html_safe
  end
end
