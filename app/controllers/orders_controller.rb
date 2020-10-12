class OrdersController < ApplicationController
  before_action :move_to_sign_in_page, only: [:index]
  before_action :move_to_top_page, only: [:index]

  def index
    @item = Item.find(params[:item_id])
    @order_address = OrderAddress.new
  end

  def new
    @order_address = OrderAddress.new
  end

  def create
    @item = Item.find(params[:item_id])
    @order_address = OrderAddress.new(order_address_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      render action: :index
    end
  end


  private
  def order_address_params
    params.require(:order_address).permit(:token, :zip_code, :prefecture_id, :city,
       :address_number, :building_name, :phone_number)
       .merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    @item = Item.find(params[:item_id])
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: @item.price,                   #商品の価格
        card:   order_address_params[:token],  #カード情報
        currency: 'jpy'
      )
  end

  def move_to_sign_in_page
    redirect_to new_user_session_path unless user_signed_in?
  end

  def move_to_top_page
    @item = Item.find(params[:item_id])
    if (current_user.id == @item.user.id) || @item.order
      redirect_to root_path
    end
  end
end
