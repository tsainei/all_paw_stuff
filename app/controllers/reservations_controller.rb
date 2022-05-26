class ReservationsController < ApplicationController
  before_action :set_reservation, only: :destroy
  before_action :set_accessory, only: %i[new create]
  def show; end

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.accessory = @accessory
    @reservation.user = current_user
    if @reservation.save
      redirect_to @accessory
    else
      render :new
    end
  end

  def destroy
    @reservation.destroy
    redirect_to @accessory
  end

  def update; end

  def edit; end

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def reservation_params
    params
      .require(:reservation)
      .permit(:start_date, :end_date)
  end

  def set_accessory
    @accessory = Accessory.find(params[:accessory_id])
    authorize @accessory
  end
end
