class ProvidersController < ApplicationController

  before_action :validate_permitions, only: [:new, :edit, :destroy]

  def index
    @providers = Provider.all
  end

  def new
    @provider = Provider.new
  end

  def create
    @provider = Provider.create(item_params)
    redirect_to providers_path
  end

  def show
    @provider = Provider.find(params[:id])
    @departments = Department.all
  end

  def edit
    @provider = Provider.find(params[:id])
  end

  def update
    @provider = Provider.find(params[:id])
    @provider.update_attributes(item_params)
    redirect_to storages_path
  end

  def destroy
    @provider = Provider.find(params[:id])
    @provider.destroy
    redirect_to providers_path
  end

  private

  def item_params
    params.require(:provider).permit(:item_name)
  end

  def validate_permitions
    unless current_user.sistem_manager? || current_user.department.dep_name == "Storage"
      flash[:error] = "You do not have permissions to perform this task"
      redirect_to providers_path
    end
  end

end
