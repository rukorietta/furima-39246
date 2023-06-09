class OrderForm
  include ActiveModel::Model
  attr_accessor :token
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :address, :building_name, :phone_number

  validates :user_id, :item_id, presence: true
  validates :postal_code, :prefecture_id, :city, :address, :phone_number, presence: true
  validates :postal_code, presence: true, format: { with: /\A\d{3}-\d{4}\z/, message: "は「3桁ハイフン4桁」の形式で入力してください" }
  validates :phone_number, format: { with: /\A\d{10,11}\z/, message: "は10桁以上11桁以内の半角数値で入力してください" }
  validates :token, presence: true
  def save
    return false if invalid?
  
    ActiveRecord::Base.transaction do
      order = Order.create(user_id: user_id, item_id: item_id)
      shipping = Shipping.create(
        order: order,
        postal_code: postal_code,
        prefecture_id: prefecture_id,
        city: city,
        address: address,
        building_name: building_name,
        phone_number: phone_number
      )
  
      unless shipping.persisted?
        raise ActiveRecord::Rollback, "Shipping creation failed"
      end
    end
  
    true
  rescue StandardError => e
    Rails.logger.error(e.message)
    false
  end
end 