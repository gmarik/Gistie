module GitRepo

  def repo_root
    Rails.root
  end

  def repo_path
    repo_root + 'repos/' + (self.id.to_s + ".git")
  end

  def repo
    if new_record? then nil
    else @repo ||= Rugged::Repository.new(repo_path.to_s)
    end
  end

  def init_repo(path = repo_path)
    @repo ||= Rugged::Repository.init_at(path.to_s, true)
  end
end
