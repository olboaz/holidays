class PlacesController < ApplicationController

  def index
    @places = Place.all.order(:name)
  end

  def new
    @place = Place.new
  end

  def create
    @place = Place.new(place_params)
    @place.user = current_user

    if @place.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
     @place = Place.find(params[id])
  end

  def send_mail
    @order = Place.find(params[:order_id])
    @restaurant = @order.user

    PdfMailer.with(rest: @restaurant).order_mailer(@order).deliver_later
    redirect_to places_path
    flash[:success] = "Place n°: #{@order.name} (#{@order.address}) envoyée par email"
  end

  private

  def place_params
    params.require(:place).permit(:name, :description, :address, :user_id)
  end




end
