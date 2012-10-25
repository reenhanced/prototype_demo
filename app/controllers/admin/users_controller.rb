class Admin::UsersController < Admin::BaseController
  respond_to :html

  def index
    @users = User.all

    respond_with @users
  end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
