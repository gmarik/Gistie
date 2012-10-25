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

  def self.init_at(path, bare = true)
    Repository.init_at(path.to_s, bare)
  end
end
