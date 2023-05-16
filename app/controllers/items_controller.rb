class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new]

  def index
    @items = Item.all
  end
  
  def new
    # ログイン状態でない場合はログインページにリダイレクト
    unless current_user
      redirect_to new_user_session_path
      return
    end
    
    # ログイン状態の場合は商品出品ページを表示
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
  
    if @item.save
      redirect_to root_path, notice: '商品を出品しました。'
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :condition_id, :delivery_day_id, :delivery_fee_id, :prefecture_id, :price, :image).merge(user_id: current_user.id)
  end
end