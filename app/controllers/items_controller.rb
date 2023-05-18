class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create] # create アクションもログイン状態でのアクセスを制限する

  def index
    @items = Item.order(created_at: :desc)
  end

  def new
    # ログイン状態の場合は商品出品ページを表示
    @item = Item.new
  end

  def create
    @item = current_user.items.build(item_params) # ログインユーザーに紐づく商品を作成

    if @item.save
      redirect_to root_path, notice: '商品を出品しました。'
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :condition_id, :delivery_day_id, :delivery_fee_id, :prefecture_id, :price, :image)
  end
end