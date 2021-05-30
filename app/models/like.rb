class Like < ApplicationRecord
  belongs_to :user
  belongs_to :question

  # validates(
  #   :question_id,
  #   uniqueness: true
  # )
  # the above validation is saying once a question is liked by a user. No other likes can be created for that particular question
  # potential like records
  #|like_id|user_id|question_id|
  #|1|30|50|
  #|2|45|50| -> user_id 45 can not like question 50 because a record with question_id 50 already exists

  # Don't let the same user like the same question more than once 
  validates(
    :question_id,
    uniqueness: {
      scope: :user_id,
      message: "has already been liked"
    }
  )
  #|like_id|user_id|question_id|
  #|1|30|50|
  #|2|45|50| This works because USER_ID is unique between the two records
  #|3|45|50| <- this doesn't work there's already a record with this same user_id question_id combo
end
