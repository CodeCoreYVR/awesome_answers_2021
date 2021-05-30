class WelcomeController < ApplicationController
  # public methods of a controller are called "actions".
  # These methods are responsible for generatinga response to a request
  def hello_world
    render(plain: "hello world")
  end

  def root
    # because of Rails convention every one of these actions will automatically render a template.
    # the tempalte it renders is inside of views/controller_name/method_name.html.erb
    # so in this case root action will render out the view `views/welcome/root.html.erb`
  end

  def contact_us

  end

  # this handles submission of the form on "/contact_us" the POST to "/process_contact"
  def process_contact
    # inside of all controller actions you have access a `request` object that represents the request being made
    
    # In rails all the information from the url and body are in a hash called `params`

    # storing values inside of instance variables will give you access to them inside of your views

    # byebug: if you add `byebug` anywhere within your application it will stop the execution of code at that point and allow you to dig around to debug stuff.
    get_name
    @email = params[:email]
    @message = params[:message]

    # if you explicitly tell rails to render a file then it will expect a file in views called `views/welcome/thank_you.html.erb`
    render :thank_you
  end

  private

  def get_name
    if params[:full_name] != ''
      @full_name = params[:full_name]
    else
      @full_name = "mickey mouse"
    end
  end
end
