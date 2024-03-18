class GeolocationController < ApplicationController
  def update
    user = User.find(params[:user_id])
    user.latitude = params[:latitude]
    user.longitude = params[:longitude]
    user.current_position_address = user.reverse_geocode
    user.save
    render json: { message: 'Mise à jour des données de localisation effectuée.' }
  end

  private

  def params_location
    params.require(:user).permit(:user_id, :latitude, :longitude)
  end
end
