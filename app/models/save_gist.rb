class SaveGist
  def initialize(gist)
    @gist = gist
  end

  def call(update_attributes = {})
    @gist.transaction do
      @gist.assign_attributes(update_attributes)
      @gist.save!
      # gist has to be persited at this point
      # as gist.id is used to generate repo's name
      @gist.init_repo if @gist.new_record?
      @gist.gist_write #async?
    end
    @gist
  end
end
