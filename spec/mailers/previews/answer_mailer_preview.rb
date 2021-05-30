# Preview all emails at http://localhost:3000/rails/mailers/answer_mailer
class AnswerMailerPreview < ActionMailer::Preview

  # Rails 4+ allows us to preview what emails are going to look like via this class.
  def hello_world
    AnswerMailer.hello_world
  end
end
