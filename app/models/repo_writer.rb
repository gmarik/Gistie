module RepoWriter

  attr_reader :repo

  NothingToCommitError = Class.new(StandardError)

  def write(blobs)
    # TODO: extract
    author = {
      email: "gitsy@gitsy.com", 
      time: Time.now,
      name: "gitsy"
    }

    named_blob_oids = write_blobs(blobs)
    tree_oid        = write_tree(named_blob_oids)
    commit_oid      = write_commit(tree_oid, author)
    # this prevents duplicated commits
    # even though commit is writen it just becomes an orphan 
    # until Garbage Collected
    # TODO: think of better implementation avoiding orphan commit object
    raise NothingToCommitError.new(repo.path) if duplicate?(commit_oid)
    ref             = set_master(commit_oid)
  end

  def duplicate?(commit_oid)
    commit = repo.lookup(commit_oid)
    return false if commit.parents.empty?
    parent_commit = commit.parents.first
    commit.tree.oid == parent_commit.tree.oid
  end

  def write_blob(blob)
    oid = repo.write(blob, :blob)
  end

  def write_blobs(blobs)
    blobs.map { |b| [b.name, write_blob(b.blob)] }
  end

  def write_tree(blob_named_sha1s, builder = Rugged::Tree::Builder.new)
    blob_named_sha1s.each do |name, oid|
      builder << {
        type: :blob,
        name: name,
        oid:  oid,
        filemode: 33188
      }
    end

    tree_sha1 = builder.write(repo)
  end

  def write_commit(tree_sha1, author, parents = commit_parent, commit = Rugged::Commit)
    commit_sha1 = commit.create(repo,
      author:      author,
      message:     "Commit\n\n",
      committer:   author,
      parents:     parents,
      tree:        tree_sha1
    )
  end

  def commit_parent
    if repo.empty? then []
    else                [repo.head.target]
    end
  end

  def set_master(commit_oid)
    ref_name =  "refs/heads/master"
    r = Rugged::Reference
    if repo.empty?
      r.create(repo, ref_name, commit_oid)
    else
      ref = r.lookup(repo, ref_name)
      ref.target = commit_oid
    end
    commit_oid
  end
end
