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

  private

  def place_params
    params.require(:place).permit(:name, :description, :address, :user_id)
  end

end
