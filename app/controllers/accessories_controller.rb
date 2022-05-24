class AccessoriesController < ApplicationController
  before_action :set_, only: [:edit, :update, :destroy]

  def index
    @accessories = Accessory.all
  end

  def new
    @accessory = Accessory.new
  end

  def create
    @accessory = Accessory.new(accesory_params)
    authorize @accessory
    @accessory.save

    redirect_to accessories_path
  end

  def edit
  end

  def update
    @accessory.update(accessory_params)

    redirect_to accessories_path
  end

  def destroy
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
