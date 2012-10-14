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
    writer = GistWriter.new(gist)
    writer.write(gist.gist_blobs)
  end
end
