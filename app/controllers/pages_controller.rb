class PagesController < ApplicationController
  include DeviseHelpers

  def index
    redirect_to dashboard_path if user_signed_in?
  end

  def dashboard
    authenticate_user!

    @spot_creator = Spot::Creator.new
    @user_spots = current_user.user_spots
  end
end
