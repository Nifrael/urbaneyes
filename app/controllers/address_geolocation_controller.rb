class AddressGeolocationController < ApplicationController
  def update
    user = User.find(params[:user_id])
    user.current_position_address = params[:address]
    user.geocode
    user.save
    render json: {
      message: 'Mise à jour des données de localisation effectuée.',
      current_position_address: user.current_position_address
    }
  end

  private

  def params_location
    params.require(:user).permit(:user_id, :address)
  end
end
