class ShareMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.share_mailer.share_file.subject
  #
  def share_file
    @user = params[:user]
    @shared_user = params[:shared_user]
    @filename = params[:filename]
    @link = params[:link]
    mail(
      to: @shared_user.email,
      from: @user.email
    )
  end
end
