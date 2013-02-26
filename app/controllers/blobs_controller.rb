class BlobsController < ApplicationController
  respond_to :html, :text

  def show
    @gist = Gist.find(params[:gist_id])
    #render text: @gist.repo.lookup(params[:id]).read_raw.data, :layout => false
    render :inline => "<html><body style=\"white-space:pre-wrap\">" + @gist.repo.lookup(params[:id]).read_raw.data + "</body></html>"
  end
end
