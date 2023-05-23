class Shipping < ApplicationRecord
  belongs_to :order
  
  validates :postal_code, presence: true
  validates :prefecture_id, presence: true
  validates :city, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true
end
 