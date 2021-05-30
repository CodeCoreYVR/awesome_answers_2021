class AnswersController < ApplicationController
    # This file was generated with the command:
    # rails g controller answers --skip-template-engine
    # The skip-template-engine option just skips
    # generated a folder 'views/answers'
    def create 
        @question = Question.find(params[:question_id])
        @answer = Answer.new answer_params
        @answer.question = @question
        @answer.user = current_user
        if @answer.save
            # AnswerMailer.notify_question_owner(@answer).deliver_now # deliver_now does this action now, it does not get added to a queue
            AnswerMailer.notify_question_owner(@answer).deliver_now # deliver_now does this action now, it does not get added to a queue
            HelloWorldJob.perform_later("someone answered a question") # <Job>.perform_later is enqueing jobs to delayed_job
            redirect_to question_path(@question)
        else
            # For the list of answers
            @answers = @question.answers.order(created_at: :desc)
            render 'questions/show'
        end
    end

    def destroy 
        @answer = Answer.find params[:id]
        if can?(:crud, @answer)
            @answer.destroy 
            redirect_to question_path(@answer.question)
        else 
            #head will send an empty HTTP response with 
            # a particular response code, in this case
            # unauthorized 401. 
            # http://billpatrianakos.me/blog/2013/10/13/list-of-rails-status-code-symbols/
            head :unauthorized
            # redirect_to root_path, alert: 'Not Authorized'
        end
    end


    private 
    
    def answer_params 
        params.require(:answer).permit(:body)
    end
end
