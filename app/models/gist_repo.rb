class GistRepo
  include Rugged

  attr_accessor :path

  def initialize(path)
    @path = path
  end

  def repo
    @repo ||= Repository.new(@path)
  end
end
