class UsersController < ApplicationController
  include DeviseHelpers

  before_action :authenticate_user!

  def update
    @resource = current_user
    @resource.update_without_password(user_params)
    render 'devise/registrations/edit', resource: current_user
  end

  private
  def user_params
    params.require(:user).permit(:notificable)
  end
end
