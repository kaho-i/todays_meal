class Shop::SearchesController < ApplicationController
  before_action :authenticate_restrant!
  def search
    @content = params[:content]
    @method = params[:method]
    @records = Reservation.search_for(@content, @method)
  end
end
