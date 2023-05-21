class OrdersController < ApplicationController

  def index
    @order_form = OrderForm.new
    @item = Item.find(params[:item_id]) if params[:item_id].present?
  end

  def create
    @order_form = OrderForm.new(order_params)
    if @order_form.save
      # 購入が成功した場合の処理
      redirect_to root_path, notice: '購入が完了しました。'
    else
      # 購入が失敗した場合の処理
      render :index
    end
  end

  private

  def order_params
    params.require(:order_form).permit(:item_id, :user_id, :postal_code, :prefecture_id, :city, :address, :building_name, :phone_number)
  end
end