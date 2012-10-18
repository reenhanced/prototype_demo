class Admin::BaseController < ApplicationController
  before_filter :admin_required
  skip_authorization_check

  protected
  def admin_required
    raise CanCan::Unauthorized unless user_signed_in? and current_user.is?(:admin)
  end
end
