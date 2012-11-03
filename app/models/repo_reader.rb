module RepoReader
  # TODO: make enumerable
  def repo_read(sha = repo.head.target)
    head = repo.lookup(sha)

    head.tree.map do |entry|
      # TODO: ensure :type is :blob here
      # otherwise will fail on :tree
      entry.merge(:content => lazy_read_blob(entry[:oid]))
    end
  end

  def read_blob(oid)
    obj = repo.lookup(oid)
    obj.content
  end

  def lazy_read_blob(oid)
    ->() { read_blob(oid) }
  end
end
