class ReservationsController < ApplicationController


  def show
  end

  def new
    @reservation = Reservation.new

  end

  def create
    @reservation = Reservation.new(reservation_params)
    authorize @reservation
    @reservation.user = current_user
  end

  def destroy
  end

  def update
  end

  def edit
  end

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def reservation_params
    params.require(:reservation).permit(:user_id, :accessory_id, :start_date, :end_date)
  end

  def set_accessory
    @accessory = Accessory.find(params[:reservation_id])
  end
end
