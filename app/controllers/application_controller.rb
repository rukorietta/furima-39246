class ApplicationController < ActionController::Base
  before_action :basic_auth
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]  # 環境変数を読み込む記述に変更
    end
  end
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :first_name, :last_name, :first_name_kana, :last_name_kana, :birth_date])
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      # 販売手数料の計算
      commission = (@item.price * 0.1).floor
      # 販売利益の計算
      profit = (@item.price - commission)
      # ビューに渡すために、インスタンス変数に保存
      @commission = commission
      @profit = profit
      render :show
    else
      render :new
    end
  end
end