class Public::ReservationsController < ApplicationController
  before_action :authenticate_user!
  def new
    @restrant = Restrant.find(params[:restrant_id])
    @reservation = Reservation.new
    @reservation.restrant_id = @restrant.id
  end

  def check
    @user = current_user
    @restrant = Restrant.find(params[:restrant_id])
    @select_date = params[:reservation][:new_date]
    @member = params[:reservation][:new_member]
    @representative = @user.family_name + @user.first_name
  end

  def create
    @user = current_user
    @restrant = Restrant.find(params[:restrant_id])
    @reservation = Reservation.create
    @reservation.user_id = @user.id
    @reservation.restrant_id = @restrant.id
    @reservation.date = params[:reservation][:new_date]
    @reservation.member = params[:reservation][:new_member]
    @reservation.name = @user.family_name + @user.first_name
    if @reservation.save
      redirect_to shops_path notice:"予約が完了しました"
    else
      render :new
    end
  end

  def index
    @reservations = Reservation.all
  end

  def show
  end

  private
  def reservation_params
    params.require(:reservation).permit(:user_id, :restrant_id, :member, :date, :name)
  end
end
