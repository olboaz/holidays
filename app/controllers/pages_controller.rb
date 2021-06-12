class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home

    @places = Place.geocoded
    @markers = @places.map do |place|

    {
      lat: place.latitude,
      lng: place.longitude,
      name: place.name,
      pseudo: place.user.username,
      user: place.user.email
    }
    end

  end
end
