class AccessoriesController < ApplicationController
  before_action :set_accessory, only: %i[show edit update destroy]
  skip_before_action :authenticate_user!, only: [:index]

  def index
    if params[:query].present?
      @query = params[:query]
      @accessoriess = Accessory.where('name ILIKE ?', "%#{params[:query]}%")
    else
      @accessories = Accessory.all
      @accessories = policy_scope(Accessory).order(created_at: :desc)
    end

    @accessories = Accessory.geocoded

    @markers =
      @accessories.map do |accessory|
        {
          lat: accessory.latitude,
          lng: accessory.longitude,
          info_window:
            render_to_string(
              partial: 'info_window',
              locals: {
                accessory: accessory,
              },
            ),
          image_url: helpers.asset_url('item_map.png'),
        }
      end
  end

  def mine
    @accessories = policy_scope(Accessory).where(params[user: current_user])
  end

  def new
    @accessory = Accessory.new
    authorize @accessory
  end

  def create
    @accessory = Accessory.new(accessory_params)
    authorize @accessory
    @accessory.user = current_user

    if @accessory.save
      redirect_to accessories_path,
                  notice: 'Accessory was successfully created.'
    else
      render :new
    end
  end

  def show
    authorize @accessory
    # @accessories = Accessory.geocoded
    @markers =
    [{
      lat: @accessory.latitude,
      lng: @accessory.longitude,
      info_window:
        render_to_string(
          partial: 'info_window',
          locals: {
          accessory: @accessory,
          },
        ),
      image_url: helpers.asset_url('item_map.png'),
    }]
  end

  def edit
    authorize @accessory
  end

  def update
    @accessory.update(accessory_params)
    authorize @accessory

    redirect_to accessories_path
  end

  def destroy
    authorize @accessory
    @accessory.destroy

    redirect_to accessories_path
  end

  private

  def accessory_params
    params.require(:accessory).permit(:name, :price, :address, :description)
  end

  def set_accessory
    @accessory = Accessory.find(params[:id])
  end
end
