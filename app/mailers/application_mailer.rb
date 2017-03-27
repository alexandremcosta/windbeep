class ApplicationMailer < ActionMailer::Base
  default from: ENV['ADMIN_EMAIL']
  layout 'mailer'

  add_template_helper(ApplicationMailerHelper)
end
