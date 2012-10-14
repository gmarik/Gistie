class CreateGist
  def call(gist)
    gist.transaction do
      gist.save!
      # gist has to be persited at this point
      # as gist.id is used to generate repo's name
      gist.init_repo
      write(gist)
    end
    gist
  end

  def write(gist)
    GistWriter.new(gist).call
  end
end
