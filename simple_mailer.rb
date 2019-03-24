require 'mail'

class SimpleMailer
  
  YOUR_MAIL_NAME     = 'print_your_email_name'.freeze
  YOUR_MAIL_PASSWORD = 'print_your_email_pass'.freeze
  MAIL_TO            = 'alert@pokupon.ua'.freeze

  def initialize
  	Mail.defaults do
      delivery_method :smtp, 
      address:        "smtp.gmail.com",
      port:           587,
      domain:         "localhost",
      authentication: "plain",
      user_name:      YOUR_MAIL_NAME,
      password:       YOUR_MAIL_PASSWORD,
      enable_starttls_auto: true
    end
  end

  def send_mail(url, code)
  	Mail.deliver do
	  from YOUR_MAIL_NAME
	  to MAIL_TO
	  subject 'status'
	  body    "Check your website #{url}, code: #{code}"
    end
  end
end