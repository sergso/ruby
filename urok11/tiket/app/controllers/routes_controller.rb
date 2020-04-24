class RoutesController < ApplicationController
  before_action :set_var, only: [:show, :destroy, :edit, :update]
  def index
    @routes = Route.all
  end
  def show
#    @route = Route.find(params[:id])
  end
  def new
    @route = Route.new
  end
  def create
    @route = Route.new(route_params)
    if @route.update(route_params)
      redirect_to @route
    else 
      render :edit
    end
  end
    def edit
 #     @route = Route.find(params[:id])
    end
   
    def update
  #    @route = Route.find(params[:id])
      if @route.update(route_params)
        redirect_to @route
      else 
        render :edit
      end
    end
    def destroy
   #   @route = Route.find(params[:id])
      @route.destroy
      redirect_to routes_path
    end
  private
  def route_params
    params.require(:route).permit(:first_name, :last_name)
  end
  def set_var
    @route = Route.find(params[:id])
  end
end
