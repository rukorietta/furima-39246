class OrdersController < ApplicationController

  def index
    @order_form = OrderForm.new
    @item = Item.find(params[:item_id]) if params[:item_id].present?

    if !user_signed_in?
      redirect_to new_user_session_path
    elsif current_user.id == @item.user_id
      redirect_to root_path
    elsif @item.sold_out?
      redirect_to root_path
    end
  end

  def create
    @order_form = OrderForm.new(order_params)
    @item = Item.find(params[:item_id]) # @itemを適切に設定する

    if @order_form.valid?
      pay_item
      @order = create_order # @orderを作成する
      create_shipping # create_shippingメソッドを呼び出す
      return redirect_to root_path
    else
      render 'index'
    end
  end

  private

  def create_shipping
    @shipping = Shipping.new(
      order_id: @order.id,
      postal_code: @order_form.postal_code,
      prefecture_id: @order_form.prefecture_id,
      city: @order_form.city,
      address: @order_form.address,
      building_name: @order_form.building_name,
      phone_number: @order_form.phone_number
    )
    @shipping.save
  end
  def order_params
    params.require(:order_form).permit(:item_id, :user_id, :postal_code, :prefecture_id, :city, :address, :building_name, :phone_number).merge(token: params[:token])
  end

  def create_order
    @order = Order.create(
      item_id: @item.id,
      user_id: current_user.id,
    )
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"] 
    Payjp::Charge.create(
      amount: @item.price,  # 商品の値段
      card: order_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end
end 