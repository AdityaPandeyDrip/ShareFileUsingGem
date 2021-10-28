class BlobsController < ApplicationController
  def index
    @q = current_user.files.blobs.ransack(params[:q])
    @files = @q.result

    @shared_files = SharedFileAssociation.get_shared_files(current_user.id)
  end
end
