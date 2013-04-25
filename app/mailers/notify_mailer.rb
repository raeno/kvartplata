class NotifyMailer < ActionMailer::Base
  default from: 'notify@kvartplata-info.ru'

  def measure_date_notification
    email = CredentialsConfig.config[:sms_email]
    subject = 'user.phone_number'
    mail :to => email, subject: subject
  end

end
