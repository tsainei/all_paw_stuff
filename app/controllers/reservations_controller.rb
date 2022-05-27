class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:destroy]
  before_action :set_accessory, only: %i[new create]

  def show; end

  def new
    @reservation = Reservation.new
    authorize @reservation
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.accessory = @accessory
    @reservation.user = current_user
    @reservation.total_price =
      @accessory.price *
        ((@reservation.end_date - @reservation.start_date).to_i)
    authorize @reservation
    if @reservation.save
      redirect_to mine_reservations_path
    else
      render :new
    end
  end

  def mine
    @reservations = policy_scope(Reservation).where(params[current_user])
  end

  def destroy
    authorize @reservation
    @reservation.destroy
    redirect_to @accessory
  end

  def update
    authorize @reservation
  end

  def edit
    authorize @reservation
  end

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date)
  end

  def set_accessory
    @accessory = Accessory.find(params[:accessory_id])
    authorize @accessory
  end
end
