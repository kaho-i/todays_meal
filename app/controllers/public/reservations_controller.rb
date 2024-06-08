class Public::ReservationsController < ApplicationController
  before_action :authenticate_user!
  def new
    @reservation = Reservation.new
    @reservation.user_id = current_user.id
  end

  def create
    @reservation = Reservations.create(reservation_params)
    @reservation.user_id = current_user.id
    @reservation.restrant_id = restrant.id
    if @reservation.save
      redirect_to shops_path notice:"予約が完了しました"
    else
      render :new
    end
  end

  def check
  end

  def index
    @reservations = Reservation.where(date: Date.today..(Date.today + 6.days))
  end

  def show
  end
  
  private
  def reservation_params
  end
end
