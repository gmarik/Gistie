class RepoTree

  include Enumerable

  class Blob

    attr_reader :name, :oid, :type, :filemode

    def initialize(tree, params)
      @tree = tree
      @name, @oid, @type, @filemode = params.values_at(:name, :oid, :type, :filemode)
    end

    def data
      @tree.lookup(@oid).content
    end

    alias_method :content, :data

  end

  attr_reader :repo, :head

  def initialize(repo, head)
    @repo = repo
    @head = head
  end

  def each(&block)
    to_enum.each(&block)
  end

  def to_enum
    Enumerator.new do |y|
      enum = tree.to_enum
      loop do
        entry = enum.next
        # TODO: add :tree(directory) support
        y << Blob.new(self, entry) if entry[:type] == :blob
      end
    end
  end

  def lookup(sha)
    repo.lookup(sha)
  end

  private

  def tree
    @tree ||= lookup(head).tree
  end

end
