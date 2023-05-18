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

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to @item, notice: "商品情報が更新されました。"
    else
      render :edit
    end
  end

  def edit
    @item = Item.find(params[:id])
    if user_signed_in?
      if @item.user == current_user
        # 編集可能なユーザーの場合は通常通り編集ページを表示
      else
        redirect_to root_path, alert: "他のユーザーの商品は編集できません。"
      end
    else
      redirect_to new_user_session_path, alert: "ログインが必要です。"
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :condition_id, :delivery_day_id, :delivery_fee_id, :prefecture_id, :price, :image)
  end
end