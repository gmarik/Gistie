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

    if @gist.save_and_commit!.valid?
      redirect_to @gist, notice: 'Gist was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @gist = Gist.find(params[:id])

    if @gist.save_and_commit!(params[:gist]).valid?
      redirect_to @gist, notice: 'Gist was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @gist = Gist.find(params[:id])

    @gist.destroy

    redirect_to gists_url, notice: 'Gist was successfully deleted'
  end
end
