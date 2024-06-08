class Public::RestrantsController < ApplicationController
  before_action :authenticate_user!
  def index
    @restrants = Restrant.all.page(params[:page]).per(10)
  end

  def show
    @restrant = Restrant.find(params[:id])
  end
end
