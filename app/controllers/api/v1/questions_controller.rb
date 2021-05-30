class Api::V1::QuestionsController < Api::ApplicationController
    before_action :find_question, only: [:show, :edit, :update, :destroy]
    def index
        # curl http://localhost:3000/api/v1/questions
        questions = Question.order(created_at: :desc)
        # provide the each_serializer key to the options hash of the render method to specify which Serializer to use on each instance.
        render(json: questions, each_serializer: QuestionCollectionSerializer)
    end

    def show
        # curl http://localhost:3000/api/v1/questions/:id
        if @question
            render(
                json: @question,
                include: [:author, { answers: [:author]}]
            )
        else 
            render(json: { error: 'Question Not Found'})
        end

    end

    def create
        question = Question.new(params.require(:question).permit(:title, :body, :tag_names))
        question.user = current_user
        if question.save
            render json: { id: question.id }
        else
            render(
                json: { errors: question.errors },
                status: 422 # unprocessable entitiy HTTP Status Code
            )
        end
    end

    def edit
    end

    def update 
        if @question.update question_params
            render json: { id: @question.id }
        else
            render :edit 
        end
    end

    def destroy
        @question.destroy 
        render(json: { status: 200 }, status: 200)
    end

    private 

    def find_question 
        @question ||= Question.find params[:id]
    end

    def question_params 
        params.require(:question).permit(:title, :body, :tag_names)
    end
end
