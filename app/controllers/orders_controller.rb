class OrdersController < ApplicationController
  def create
    @order_form = OrderForm.new(order_params)
    if @order_form.valid?
      token = params[:token] # トークンを受け取るパラメータを追加

      # PAY.JPのAPIを使用して決済処理を行う
      begin
        Payjp.api_key = ENV['PAYJP_SECRET_KEY']
        charge = Payjp::Charge.create(
          amount: @order_form.item.price, # 決済金額
          card: token, # トークンを指定
          currency: 'jpy'
        )

        if charge.paid
          # 決済が成功した場合の処理
          @order_form.save_order_information
          redirect_to root_path, notice: "購入が完了しました。"
        else
          # 決済が失敗した場合の処理
          flash.now[:alert] = "決済が失敗しました。"
          render :new
        end
      rescue Payjp::PayjpError => e
        # 決済エラーが発生した場合の処理
        flash.now[:alert] = "決済エラーが発生しました。"
        render :new
      end
    else
      # バリデーションエラーがある場合の処理
      render :new
    end
  end

  private

  def order_params
    params.require(:order_form).permit(:item_id, :postal_code, :prefecture_id, :city, :address, :building_name, :phone_number)
  end
end