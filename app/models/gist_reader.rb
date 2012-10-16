module GistReader
  # TODO: make enumerable
  def repo_read(sha = repo.head.target)
    head = repo.lookup(sha)

    head.tree.map do |entry|
      # TODO: ensure :type is :blob here
      entry.merge(:content => read_blob(entry[:oid]))
    end
  end

  def read_blob(oid)
    obj = repo.lookup(oid)
    obj.content
  end
end
