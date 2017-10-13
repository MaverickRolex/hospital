class ItemTransfersController < ApplicationController

  before_action :validate_permitions, only: [:new, :edit, :destroy]

  def index
    @transfers = ItemTransfer.all
  end

  def new
    @transfer = ItemTransfer.new
    @users = User.all
    @items = Storage.all
    @departments = Department.all
  end

  def create
    @transfer = ItemTransfer.create(transfer_params)
    redirect_to item_transfers_path
  end

  def edit
    @transfer = ItemTransfer.find(params[:id])
    @users = User.all
    @items = Storage.all
    @departments = Department.all
  end

  def update
    @transfer = ItemTransfer.find(params[:id])
    @transfer.update_attributes(transfer_params)
    redirect_to item_transfers_path
  end

  def destroy
    @transfer = ItemTransfer.find(params[:id])
    @transfer.destroy
    redirect_to item_transfers_path
  end

  private

  def transfer_params
    params.require(:item_transfer).
      permit(:storage_oper_user_id, :trans_request_user_id, :item_id, :origin_dep_id, :destiny_dep_id, :quantity)
  end

  def validate_permitions
    unless current_user.sistem_manager? or current_user.department.dep_name == "Storage"
      flash[:error] = "You do not have permissions to perform this task"
      redirect_to item_transfers_path
    end
  end

end
