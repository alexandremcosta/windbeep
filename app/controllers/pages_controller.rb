class PagesController < ApplicationController
  include DeviseHelpers

  def index
    redirect_to dashboard_path if user_signed_in?
  end

  def dashboard
  end
end
