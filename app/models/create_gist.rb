class CreateGist
  def call(gist)
    gist.transaction do
      gist.save!
      gist.init_repo
      # gist.commit_content
    end
    gist
  end
end
