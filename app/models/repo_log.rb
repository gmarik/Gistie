class RepoLog

  class Commit
    def initialize(commit)
      @commit = commit
    end

    def created_at
      @commit.time
    end

    def pretty_sha
      sha[0, 9]
    end

    def sha
      @commit.oid
    end
    alias_method :oid, :sha
  end

  include Enumerable

  def initialize(repo, opts = {})
    @repo = repo
    @target = opts.delete(:target) || @repo.head.target
    @walker = walker(@repo, @target)
  end

  def each(&block)
    to_enum.each(&block)
  end

  def walker(repo, target)
    walker = Rugged::Walker.new(repo)
    walker.sorting(Rugged::SORT_DATE)
    walker.push(target)
    walker
  end

  def to_enum
    Enumerator.new do |y|
      enum = @walker.to_enum
      loop do
        y << Commit.new(enum.next)
      end
    end
  end
end
