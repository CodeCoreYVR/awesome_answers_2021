require "rails_helper"
# https://rspec.info/documentation/3.9/rspec-expectations/RSpec.html <-- RSPEC matchers docs
RSpec.describe QuestionsController, type: :controller do
  def current_user
    @current_user ||= User.create({first_name: 'jon', last_name: 'snow', email: 'jon@snow.ca', password: '123456'})
  end
  describe "#new" do
    context "without a signed in user" do
      it "redirect them to the login page" do
        get :new
        expect(response).to(redirect_to(new_session_path))
      end
    end

    context "with a signed in user" do
      it "renders a page" do
        # Given
        # a currently signed in user
        session[:user_id] = current_user.id
        
        # When
        # they go to the /questions/new page
          get :new

        # Then
        # response should give us back a new page
          expect(response).to(render_template(:new))
      end
  
      it "creates a new @question instance" do
        session[:user_id] = current_user.id

        get(:new)

        expect(assigns(:question)).to(be_a_new(Question))
      end
    end
  end

  describe "#create" do

    context "user not signed in" do
      it "redirects to the sign in page" do
        get :create
        expect(response).to(redirect_to(new_session_path))
      end
    end

    context "user is signed in" do

      context "with invalid data" do
        it "does not insert a new record in the database" do
          session[:user_id] = current_user.id
          before_count = Question.count
          post(:create, params: { question: {title: '', body:'abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz'} })
          after_count = Question.count
          expect(after_count).to(eq(before_count))
        end
      end

      context "with valid data" do
        it "insert a record into the database" do
          session[:user_id] = current_user.id
          before_count = Question.count
          post(:create, params: { question: {title: 'abcdefghijklmnopqrstuvwxyz', body:'abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz'} })
          after_count = Question.count
          expect(after_count).to(eq(before_count + 1))
        end
      end
    end

  end
end