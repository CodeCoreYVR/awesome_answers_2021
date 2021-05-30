class AnswerMailer < ApplicationMailer

  def hello_world
    mail(
      to: "brandon@codecore.ca",
      from: "info@awesome_answers.io",
      cc: "tech_support@codecore.ca",
      bcc: "some_more_people@example.ca",
      subject: "Hello, World from Awesome Answers App!"
    )
    # the mail method will automatically look for a template inside of `app/views/MAILER_NAME/METHOD_NAME`
    # if you want to specify a template you can add the keys `tempalte_path` and `template_name` to the options hash
  end

  def notify_question_owner(answer)
    @answer = answer
    @question = answer.question
    @question_owner = @question.user

    mail(
      to: @question_owner.email,
      subject: "#{answer.user.first_name} answerd your question!"
    )
  end
  # inside of a controller teh AnswerMailer is loaded in
  # we can invoke this method by calling AnswerMailer.notify_question_owner(@answer).deliver_now
end
