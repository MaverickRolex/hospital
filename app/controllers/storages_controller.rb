class StoragesController < ApplicationController

  before_action :validate_permitions, only: [:new, :update, :edit, :destroy]

  def index
    @items = Storage.all
    @departments = Department.all
  end

  def new
    @item = Storage.new
  end

  def create
    @item = Storage.new(item_params)
    @item.save
    redirect_to storages_path
  end

  def show
    @item = Storage.find(params[:id])
    @departments = Department.all
  end

  def edit
    @item = Storage.find(params[:id])
  end

  def update
    @item = Storage.find(params[:id])
    @item.update_attributes(item_params)
    redirect_to storages_path
  end

  def destroy
    @item = Storage.find(params[:id])
    @item.destroy
    redirect_to storages_path
  end

  private

  def item_params
    params.require(:storage).permit(:item_name)
  end

  def validate_permitions
    unless current_user.sistem_manager? or current_user.department_id == 5
      flash[:error] = "You do not have permissions to perform this task"
      redirect_to storages_path
    end
  end

end
