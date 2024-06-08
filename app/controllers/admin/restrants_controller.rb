class Admin::RestrantsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @restrants = Restrant.all.page(params[:page]).per(10)
  end

  def show
    @restrant = Restrant.find(params[:id])
  end

  def edit
    @restrant = Restrant.find(params[:id])
  end

  def update
    @restrant = Restrant.find(params[:id])
    if @restrant.update(restrant_params)
      flash[:notice] = '店舗情報を編集しました'
      redirect_to admin_restrants_path
    else
      render :edit
    end
  end

  private
  def restrant_params
    params.require(:restrant).permit(:name, :telephone_number, :address, :is_open)
  end
end
