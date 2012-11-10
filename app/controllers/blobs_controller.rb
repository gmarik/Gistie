class BlobsController < ApplicationController
  respond_to :html, :text

  def show
    @gist = Gist.find(params[:gist_id])
    render text: @gist.repo.lookup(params[:id]).read_raw.data, :layout => false
  end
end
