class Api::UsersController < Api::ApiController
  acts_as_token_authentication_handler_for User, fallback: :exception

  def index
    users = User.all
    render json: users, status: :ok
  end

  def create
    User.create!(user_params)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
