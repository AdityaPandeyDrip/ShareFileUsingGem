class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  helper_method :get_url, :file_size_verbose, :get_shared_url

  def get_shared_url(user_id, file_id)
    shared_file = User.find(user_id).files.find(file_id)
    get_url(shared_file) if shared_file.present?
  end

  def get_url(blob)
    Rails.application.routes.url_helpers.rails_blob_path(blob, only_path: true)
  end

  def file_size_verbose(byte)
    @kb = byte / 1024
    if @kb < 1024
      return "#{@kb} KB"
    end
    @mb = @kb / 1024
    if @mb < 1024
      return "#{@mb} MB"
    end
    @gb = @mb / 1024
    return "#{@gb} GB"
  end
end
