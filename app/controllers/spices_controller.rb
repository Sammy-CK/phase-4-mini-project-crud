class SpicesController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :no_spice_render
    wrap_parameters format: []
    def index
        render json: Spice.all
    end

    def create
        spice = Spice.create(spice_params)
        render json: spice, status: 201
    end

    def update
        spice = find_spice
        spice.update(spice_params)
        render json: spice
    end

    def destroy
        spice = find_spice
        spice.destroy
        head :no_content
    end

    private
    def find_spice
        Spice.find(params[:id])
    end

    def spice_params
        params.permit(:title, :image, :description, :notes, :rating)
    end
    
    def no_spice_render
        render json: {error: "No spice found"}, status: :not_found
    end
end
