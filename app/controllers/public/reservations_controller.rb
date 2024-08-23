class Public::ReservationsController < ApplicationController
  before_action :authenticate_user!
  def new
    @restrant = Restrant.find(params[:restrant_id])
    @reservation = Reservation.new
    @reservation.restrant_id = @restrant.id
  end

  def create
    @user = current_user
    @restrant = Restrant.find(params[:restrant_id])
    @reservation = Reservations.create(reservation_params)
    @reservation.user_id = @user.id
    @reservation.restrant_id = @restrant.id
    @reservation.name = @user.family_name + @user.first_name
    if @reservation.save
      redirect_to shops_path notice:"予約が完了しました"
    else
      render :new
    end
  end

  def check
    @user = current_user
    @restrant = Restrant.find(params[:restrant_id])
    @select_date = params[:reservation][:date]
    @representative = @user.family_name + @user.first_name
  end

  def index
  end

  def show
  end

  private
  def reservation_params
    params.require(:reservation).permit(:user_id, :restrant_id, :member, :date, :name)
  end
end
