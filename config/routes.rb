Rails.application.routes.draw do
  # this a route for delayed job web. This allows us to see a dashboard at a path
  match "/delayed_job" => DelayedJobWeb, :anchor => false, :via => [:get, :post]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # if you want to see the routes & helpers you have drawn out visit http://localhost:3000/rails/info/routes

  # get("/questions", to: "questions#index")
  # get("/questions/new", to: "questions#new", as: :new_question) #adding a `as: :new_question` option to the route will change the helper path name. This is to adhere to rails convention
  # post("/questions", to: "questions#create")

  # # creates a dynamic URL paremter called :id. we can access this dynamic id using params[:id]
  # get("/questions/:id", to: "questions#show", as: :question)
  # delete("/questions/:id", to: "questions#destroy")
  # get("/questions/:id/edit", to: "questions#edit", as: :edit_question)
  # patch("/questions/:id", to: "questions#update")

  resources :users, only: [:new, :create]
  resource :user, only: [:edit, :update]
  resource :session, only: [:new, :create, :destroy]
  # notice resource here is singular. This is a different method that is like resources.
  # this method is used for a resource which you will only create one of.
  # usually this resource will not need a dynamic id
  # https://api.rubyonrails.org/classes/ActionDispatch/Routing/Mapper/Resources.html#method-i-resource

  # resources :questions #build the CRUD RESTful routes. (all of the above routes for questions)
  # 'resources' method will generate all CRUD routes
  # following RESTful conventions for a resource 
  # It will assume there is a controller named after the
  # first argument, pluralized and PascalCased
  resources :questions do
    resources :likes, shallow: true, only: [:create, :destroy]
    # shallow: true option changes the PATH of the created route
    # Orignal route without shallow: true => /questions/15/likes/20
    # Route with shallow: true => likes/20

    # Routes written inside of a block passed to
    # a resources method will be pre-fixed by 
    # a path corresponding to the passed in symbol. 
    # In this case, all nested routes will be pre-fixed
    # with '/questions/:question_id'
    resources :answers, only: [:create, :destroy]
    # equivalent to: 
    # resources :answers, except: [:show, :index, :new, :edit, :update]
    # question_answers_path(<question-id>)
    # question_answer_url(<question-id>)
    # question_answers_path(@quation)

    get :liked, on: :collection
    # above route creats a path like: GET "/questions/liked" # kind of similar to questions index but only show the questions that the user has liked
  end
  get("/questions/faq", to: "questions#faq")
  # Our application is running on localhost:3000
  # Inside of this is where we define what resources we want available to users
  
  # URL: http://localhost:3000/path
  # HTTP Request are used to interact with our server. They're made up of a HTTP VERB and a PATH
  # VERB     PATH       CONTROLLER    PUBLIC METHOD
  # 👇          👇            👇         👇
  get("/hello_world", to: "welcome#hello_world") # when someone visits GET "/hello_world" they are sent to the welcome controller, hello_world action.

  # GET "/" WelcomeController.root method gets called
  get("/", to: "welcome#root", as: :root)

  # GET "/contact_us"
  get("/contact_us", to: "welcome#contact_us")

  # POST "/process_contact"
  post("/process_contact", to: "welcome#process_contact")
  # delete()
  # patch()
  resources :job_posts

    # API routes

  # The namespace method in Rails routes makes it so that
  # your app will automatically look in a directory api,
  # then in a sub directory v1 for QuestionsController

  # The option 'defaults: { format: :json }' will set 'json' as
  # the default response format for all routes contained within
  # the block.

  # tldr: namespace change the path of the route as well as which controller method responds to the requeset. 
  
  # /api/v1/questions
  # /api/v1/questions/:id
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :questions

      resource :session, only: [:create, :destroy]
      # GET /api/v1/users/current -> SessionsController#current
      get("/users/current", to: "sessions#current")
      resources :users, only: [:create]
    end
  end

end
