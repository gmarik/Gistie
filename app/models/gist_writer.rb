class GistWriter

  attr_reader :repo

  def initialize(repo)
    @repo = repo
  end

  def write(blobs)
    author = {
      email: "gitsy@gitsy.com", 
      time: Time.now,
      name: "gitsy"
    }

    named_blob_oids = write_blobs(blobs)
    tree_oid        = write_tree(named_blob_oids)
    commit_oid      = write_commit(tree_oid, author)
    ref             = set_master(commit_oid)
  end

  def write_blobs(blobs)
    blobs.map do |b|
      # oid - "object id" is a SHA1 hash
      oid = repo.write(b.blob, :blob)
      [b.name, oid]
    end
  end

  def write_tree(blob_named_sha1s, builder = Rugged::Tree::Builder.new )
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
