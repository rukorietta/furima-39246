class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :destroy] # create アクションもログイン状態でのアクセスを制限する
  before_action :set_item, only: [:show, :update, :edit, :destroy]

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
    if @item.sold_out? && user_signed_in? && current_user.id != @item.user_id
      redirect_to root_path
    end
  end

  def update
    if @item.update(item_params)
      redirect_to @item, notice: "商品情報が更新されました。"
    else
      render :edit
    end
  end

  def edit
     if @item.user != current_user
       redirect_to root_path, alert: "他のユーザーの商品は編集できません。"
     end
  end
  
  def set_item
    @item = Item.find(params[:id])
  end

  def destroy
    if current_user == @item.user
      @item.destroy
      redirect_to root_path, notice: '商品を削除しました。'
    else
      redirect_to root_path, alert: '他のユーザーの商品は削除できません。'
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :condition_id, :delivery_day_id, :delivery_fee_id, :prefecture_id, :price, :image)
  end
end