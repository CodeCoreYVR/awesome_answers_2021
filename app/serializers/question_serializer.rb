class QuestionSerializer < ActiveModel::Serializer

  # Before rails sends JSON it will check to see if the model has a serializer with the same name. If rails finds a serializer it will automatically serialize the instances into a JSON response

  # attributes method provided by active model serializer. Define what gets returned as JSON within this method.
  # https://github.com/rails-api/active_model_serializers/blob/v0.10.6/docs/general/serializers.md

  attributes(
    :id,
    :title,
    :body,
    :randomstuff,
    :created_at,
    :updated_at,
    :view_count,
    :like_count
  )

  # To include associated models, use the same named method for creating associations
  # you can re-name the association with a key. This will show up as the key for the association in the JSON response
  belongs_to :user, key: :author
  has_many :answers

  class AnswerSerializer < ActiveModel::Serializer
    
    attributes(
      :id,
      :body,
      :created_at
    )

    belongs_to :user, key: :author
  end

  def randomstuff
    "random stuff serializer has added to our json response"
  end

  def like_count
    # object refers to the instance of the model being serialized. Kind of like "this" in javascript or "self" in ruby.
    object.likes.count
  end

  
end
