class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :item_find_params_id, only: [:show, :edit, :update]
  before_action :move_to_top_page, only: [:edit]
  before_action :search_item, only: [:index, :search, :show]

  def index
    @items = Item.all.order('created_at DESC')
  end

  def search
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def destroy
    item = Item.find(params[:id])
    if item.valid?
      item.destroy
      redirect_to root_path
    else
      render action: :show
    end
  end

  def edit
  end

  def update
    @item.update(item_params)
    if @item.valid?
      redirect_to action: :show
    else
      render action: :edit
    end
  end

  private

  def item_find_params_id
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(
      :image, :title, :explanation, :category_id, :status_id, :transfer_fee_id,
      :from_address_id, :delivery_day_id, :price
    ).merge(user_id: current_user.id)
  end

  def move_to_top_page
    redirect_to root_path if @item.order || (current_user.id != @item.user.id)
  end
end
