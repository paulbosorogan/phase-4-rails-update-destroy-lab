class PlantsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def change_stock_status 
    plant = plant_find 
    plant.update(is_in_stock: false)
    render json: plant 
  end
  # GET /plants
  def index
    plants = Plant.all
    render json: plants
  end

  # GET /plants/:id
  def show
    plant = plant_find
    render json: plant
  end

  # POST /plants
  def create
    plant = Plant.create(plant_params)
    render json: plant, status: :created
  end
  # PATCH /plants/:id/is_in_stock
  def update 
    plant = plant_find
    plant.update(plant_params)
    render json: plant
  end
  # DELETE 
    def destroy 
      plant = plant_find
      plant.destroy 
      head :no_content
    end 

  private

  def plant_find 
    Plant.find(params[:id])
  end 

  def render_not_found_response 
    render json: {error: "Bird not found"}, status: :not_found
  end

  def plant_params
    params.permit(:name, :image, :price, :is_in_stock)
  end
end
