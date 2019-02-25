class UserMailer < ApplicationMailer

  def password_reset(user_email, reset_link)
    @email = user_email
    @resetlink = reset_link
    mail(to: @email, subject: 'Data Capture App Password Reset Link')
  end
  
end
