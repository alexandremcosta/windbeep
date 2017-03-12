class UserSpotsController < ApplicationController
  before_action :authenticate_user!

  def create
    @spot_creator = Spot::Creator.new(spot_params)
    if @spot_creator.save
      flash[:notice] = "Successfully created notification."
      redirect_to dashboard_path
    else
      render "new"
    end
  end

  def destroy
    UserSpot.find(destroy_params).destroy
    redirect_to dashboard_path
  end

  private
  def spot_params
    params.require(:spot_creator).permit(:url).merge({user: current_user})
  end

  def destroy_params
    params.require(:id)
  end
end
