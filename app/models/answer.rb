class Answer < ApplicationRecord
  # Rails guide on Associations:

  # By default, 'belongs_to' will create a validation
  # such as:
  # 'validates :question_id, presence: true'
  # It can be disabled by passing option
  # 'optional: true' to the belongs_to method
  belongs_to :question
  belongs_to :user

  # The following instance method are added to the 
  # Answer model with the line belongs_to :question.
  # They simplify interaction with the associated question:
  # .question
  # .question=(associate)
  # .build_question(attributes = {})
  # .create_question(attributes = {})
  # .create_question!(attributes = {})
  # .reload_question


  validates :body, presence: true
  # Note if you want to add your own validation message you can type your validates like below:
  # validates :body, presence: { message: "My own validation message" }
end
