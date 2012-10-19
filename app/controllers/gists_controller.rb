class GistsController < ApplicationController
  respond_to :html

  def index
    @gists = Gist.all
  end

  def show
    @gist = Gist.find(params[:id])
  end

  def new
    @gist = Gist.new
  end

  def edit
    @gist = Gist.find(params[:id])
  end

  def create
    @gist = Gist.new(params[:gist])

    if CreateGist.new.call(@gist)
      redirect_to @gist, notice: 'Gist was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @gist = Gist.find(params[:id])
    @gist.assign_attributes(params[:gist])

    if CreateGist.new.call(@gist).valid?
      redirect_to @gist, notice: 'Gist was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @gist = Gist.find(params[:id])
    @gist.destroy

    format.html { redirect_to gists_url }
  end
end
