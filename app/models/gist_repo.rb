class GistRepo
  include Rugged
  include RepoReader
  include RepoWriter

  attr_reader :path

  def initialize(path)
    @path = path
  end

  def repo
    @repo ||= Repository.new(@path)
  end

  def self.init_named_repo(name, bare = true)
    Repository.init_at(repo_path(name), bare)
  end

  def self.named(name)
    new(repo_path(name))
  end

  def self.repo_path(name, root = Rails.configuration.repo_root)
    (root + ( name + ".git/")).to_s
  end
end
