class HomeController < ApplicationController
  def index
    hint = params[:hint].present? ? params[:hint] : '*'
    file_ind = ActiveStorageBlob.search(hint).map{|file| file.id}
    @files = current_user.files.blobs.where(id: file_ind)

    case params[:sort]
    when 'created_at'
      @files = @files.order(params[:sort])
    when 'name'
      @files = @files.all.sort_by{|file| file.filename }
    when 'size'
      @files = @files.all.sort_by{|file| file.byte_size }
    end

    @shared_files = SharedFileAssociation.get_shared_files(current_user.id)
    case params[:share_sort]
    when 'created_at'
      @shared_files = @shared_files.order(params[:share_sort])
    when 'name'
      @shared_files = @shared_files.all.sort_by{|file| file.filename }
    when 'size'
      @shared_files = @shared_files.all.sort_by{|file| file.byte_size }
    end
  end
end
