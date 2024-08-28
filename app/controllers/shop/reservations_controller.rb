class Shop::ReservationsController < ApplicationController
  before_action :authenticate_restrant!
  def index
    @restrant = current_restrant
    @reservations = Reservation.where(restrant_id: @restrant.id).order(date: :asc).page(params[:page]).per(10)
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def edit
    @reservation = Reservation.find(params[:id])
  end
  
  def update
    @reservation = Reservation.find(params[:id])
    if @reservation.update(reservation_params)
      flash[:notice] = '編集しました'
      redirect_to shop_reservation_path(@reservation)
    else
      render :edit
    end
  end
  
  private
  def reservation_params
    params.require(:reservation).permit(:member, :date, :status)
  end
end
