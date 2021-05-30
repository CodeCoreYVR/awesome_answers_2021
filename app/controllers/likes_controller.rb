class LikesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy] 

  def create
    # 1) question id -> question that is going to be liked. This comes from params
    # 2) user_id -> user that liked this question. This comes from session
    question = Question.find params[:question_id]
    like = Like.new(question: question, user: current_user)

    if !can?(:like, question)
      flash[:danger] = "You can't like your own question...."
    elsif like.save
      flash[:success] = "Question Liked"
    else
      flash[:danger] = like.errors.full_messages.join(", ")
    end
    redirect_to question_path(question)
  end

  def destroy
    # like = Like.find params[:id]. with this way a user is able to search ALL likes
    like = current_user.likes.find params[:id] # this way user can only search his/hers likes

    if !can?(:destroy, like)
      flash[:warning] = "you can't destroy a like you don't own"
    elsif like.destroy
      flash[:success] = "Question Unliked"
    else
      flash[:warning] = "It's rude to unlike something you've already liked"
    end

    redirect_to question_path(like.question)
  end
end
