class Admin::UsersController < Admin::BaseController
  respond_to :html

  def index
    @users = User.all

    respond_with @users
  end

  def new
    @user = User.new

    respond_with @user
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    respond_with(@user) do |format|
      if @user.save
        format.html { redirect_to admin_users_path, notice: 'User was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @user = User.find(params[:id])
    password_changed = user_params[:password].present?

    successfully_updated = if password_changed
                             @user.update_attributes(user_params)
                           else
                             @user.update_without_password(user_params)
                           end

    respond_with(@user) do |format|
      if successfully_updated
        sign_in(:user, @user, :bypass => true) if current_user == @user
        format.html { redirect_to admin_users_path, notice: 'User was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_with(@user) do |format|
      format.html { redirect_to admin_users_url }
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
