class PlacesController < ApplicationController

  def index
    @places = Place.all.order(:name)
  end

  def new
    @place = Place.new
    @place.upc = params[:upc]
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

  def edit
    @place = Place.find(params[:id])
  end

  def update
    @place = Place.find(params[:id])

    if @place.update(place_params)
      redirect_to place_path(@place)
    else
      render :new
    end
  end

  def show
     @place = Place.find(params[:id])
  end

  def send_mail
    @order = Place.find(params[:order_id])
    @restaurant = @order.user

    PdfMailer.with(rest: @restaurant).order_mailer(@order).deliver_later
    redirect_to places_path
    flash[:success] = "Place n°: #{@order.name} (#{@order.address}) envoyée par email"
  end

  def get_barcode
    @place = Place.find(params[:id])
    @place.update(upc: params[:upc])
    redirect_to @place
  end

  private

  def place_params
    params.require(:place).permit(:name, :description, :address, :user_id, :upc )
  end

end
