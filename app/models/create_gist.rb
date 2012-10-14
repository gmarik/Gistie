class CreateGist
  def call(gist)
    gist.transaction do
      gist.save!
      gist.init_repo
      write(gist)
    end
    gist
  end

  def write(gist)
    GistWriter.new(gist).call
  end
end
