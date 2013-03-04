class BlobsController < ApplicationController
  def show
    @gist = Gist.find(params[:gist_id])
    render text: @gist.repo.lookup(params[:id]).read_raw.data, :layout => false, :content_type => 'text/plain'
  end
end
