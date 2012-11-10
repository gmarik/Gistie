class GistBlobPresenter

  delegate :name, :content, :data, :filemode, :oid, :to => :gist_blob

  attr_reader :gist_blob

  def initialize(blob)
    @gist_blob = blob
  end

  def highlight(filename, src)
    HighlightedSource.new(name, src).to_formatted_html.html_safe
  end

  def pretty_excerpt(limit = 4)
    src = content.split("\n").take(limit).join("\n")
    highlight(name, src)
  end

  def pretty_content
    highlight(name, content)
  end

end
