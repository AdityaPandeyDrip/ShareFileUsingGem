class ShareController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    file = current_user.files.find(params[:file]) if params[:file].present?

    if user.present? && file.present? && user != current_user
      shared_file = SharedFileAssociation.find_by(user_id: current_user.id,
        shared_user_id: user.id,
        file_id: file.id
      )
      if shared_file.blank?
        shared_file = SharedFileAssociation.create(
                          user_id: current_user.id,
                          shared_user_id: user.id,
                          file_id: file.id
                        )
      end
      ShareMailer.with(user: current_user, shared_user: user,filename: file.filename.to_s, link: 'http://localhost:3000/').share_file.deliver_later

      if shared_file.errors.present?
        flash[:notice] = 'File sharing Unsuccessfull'
      else
        flash[:notice] = 'File shared Successfully'
      end
    else
      flash[:notice] = 'EmailId Invalid'
    end
    redirect_to '/'
  end

  def new
    @file = params[:file]
  end

  def delete
    shared_file = SharedFileAssociation.find_by(id: params[:file], shared_user_id: current_user.id)
    if shared_file.present?
      shared_file.destroy
      flash[:notice] = 'Shared File Deleted Successfully'
    else
      flash[:notice] = 'Shared File Deletion Unsuccessfull'
    end
    redirect_to '/'
  end
end
