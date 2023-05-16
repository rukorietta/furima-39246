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
    unless @item.valid?
      @item.item_imgs.new
      render :new and return
    end

    @item.save
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :description, :category_id, :condition_id, :delivery_day_id, :delivery_fee_id, :prefecture_id, :user_id, :price, { images: [] })
  end
end