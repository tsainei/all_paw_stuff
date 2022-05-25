class AccessoriesController < ApplicationController
  before_action :set_accessory, only: %i[show edit update destroy]

  def index
    if params[:query].present?
      @query = params[:query]
      @accessoriess = Accessory.where("name ILIKE ?","%#{params[:query]}%")
    else
      @accessories = Accessory.all
      @accessories = policy_scope(Accessory).order(created_at: :desc)
    end
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
