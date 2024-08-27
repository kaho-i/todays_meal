class Public::ReservationsController < ApplicationController
  before_action :authenticate_user!
  def new
    @reservation = Reservation.new
  end

  def check
    @user = current_user
    @restrant_id = params[:reservation][:restrant_name]
    @restrant = Restrant.find(@restrant_id)
    @select_date = params[:reservation][:new_date]
    @member = params[:reservation][:new_member]
  end

  def create
    @user = current_user
    restrant = params[:reservation][:restrant_name]
    select_date = params[:reservation][:new_date]
    select_member = params[:reservation][:new_member]
    @reservation = Reservation.new
    @reservation.user_id = @user.id
    @reservation.restrant_id = restrant
    @reservation.date = select_date
    @reservation.member = select_member
    @reservation.name = @user.family_name + @user.first_name
    if @reservation.save
      redirect_to reservations_path notice: "予約が完了しました"
    else
      render :new
    end
  end

  def index
    @user = current_user
    @reservations = Reservation.where(user_id: @user.id).page(params[:page]).per(10)
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  private
  def reservation_params
    params.require(:reservation).permit(:user_id, :restrant_id, :member, :date, :name)
  end
end
