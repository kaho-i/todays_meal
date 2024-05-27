class Shop::RestrantsController < ApplicationController
  before_action :authenticate_restrant!
  
  def show
    @restrant = current_restrant
  end

  def edit
    @restrant = current_restrant
  end
  
  def update
    @restrant = current_restrant
    if @restrant.update(restrant_params)
      redirect_to shop_mypage_path
    else
      render :edit
    end
  end
  
  def confirm
  end
  
  def close
    @restrant = current_restrant
    @restrant.update(is_open: false)
    reset_session
    redirect_to shop_path
  end
  
  private
  
  def restrant_params
    params.require(:restrant).permit(:name, :telephone_number, :address)
  end
end
