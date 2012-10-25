class Admin::UsersController < Admin::BaseController
  respond_to :html

  def index
    @users = User.all

    respond_with @users
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
