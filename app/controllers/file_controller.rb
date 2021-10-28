class FileController < ApplicationController

  def attach
    file = params[:user][:file]
    if file.size < 10.megabytes
      if current_user.files.attach(file)
        flash[:notice] = 'File uploaded Successfully'
      else
        flash[:notice] = 'File uploading Unsuccessfull'
      end
    else
      flash[:notice] = 'File size should be less than 10 Megabyte'
    end
    redirect_to '/'
  end

  def delete
    file = current_user.files.find_by(id: params[:file])
    if file.present?
      file.purge
      current_user.shared_file_associations.where(file_id: 1).destroy_all
      flash[:notice] = 'File Deleted Successfully'
    else
      flash[:notice] = 'File Deletion Unsuccessfull'
    end
    redirect_to '/'
  end
end
