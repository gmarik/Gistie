class RepoLog

  def initialize(repo, opts = {})
    @limit = opts.delete(:limit) || 10
    @repo = repo
    @target = opts.delete(:target) || @repo.head.target
  end


  def commits
    w = Rugged::Walker.new(@repo)
    w.sorting(Rugged::SORT_DATE)
    w.push(@target)
    w.take(@limit)
  end

  def commit_oids
    commits.map(&:oid)
  end

  def pretty_commits
    commit_oids.map {|oid| oid[0, 9]}
  end
end
