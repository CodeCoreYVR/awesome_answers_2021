class ApplicationMailer < ActionMailer::Base
  # make sure this email is valid or else emails might not be sent.
  default from: 'no-reply@awesome-answers.io'
  layout 'mailer'
end
