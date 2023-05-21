class OrderForm
  include ActiveModel::Model

  attr_accessor :item_id, :postal_code, :prefecture_id, :city, :address, :building_name, :phone_number
  validates :postal_code, presence: true
  validates :prefecture_id, presence: true
  validates :city, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true
  validates :token, presence: true

  def save
    return false unless valid?

    # データをテーブルに保存する処理を記述

    create_payment_intent
  end

  private

  def create_payment_intent
    # PAY.JPのトークン作成と決済処理を行うコードを実装
    # PAY.JP APIを使用してクレジットカード情報をトークン化し、トークンを元に決済を実行する

    # 例:
    # token = Payjp::Token.create(
    #   card: {
    #     number: card_number,
    #     exp_month: expiration_month,
    #     exp_year: expiration_year,
    #     cvc: security_code
    #   }
    # )
    #
    # charge = Payjp::Charge.create(
    #   amount: item.price,
    #   card: token.id,
    #   currency: 'jpy'
    # )

    true # 仮の成功ステータス
  end
end