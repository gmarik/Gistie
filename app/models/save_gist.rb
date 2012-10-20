class SaveGist
  def initialize(gist)
    @gist = gist
  end

  def call(new_attributes = {})
    @gist.transaction do
      @gist.assign_attributes(new_attributes)
      @gist.save!
      # gist has to be persited at this point
      # as gist.id is used to generate repo's name
      @gist.init_repo if @gist.new_record?
      write #async?
    end
    @gist
  end

  def write
    GistWriter.new(@gist).()
  end
end
