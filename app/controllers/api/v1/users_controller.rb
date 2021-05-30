class Api::V1::UsersController < Api::ApplicationController
  def create
    user = User.new params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    if user.save
      render(json: {id: user.id})
    else
      render(json: {status: 422, errors: user.errors})
    end
  end
end
