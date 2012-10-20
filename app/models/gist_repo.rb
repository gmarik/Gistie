class GistRepo
  include Rugged
  include RepoReader
  include RepoWriter

  attr_accessor :path

  def initialize(path)
    @path = path
  end

  def repo
    @repo ||= Repository.new(@path)
  end
end
