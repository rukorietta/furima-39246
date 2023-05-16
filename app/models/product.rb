class Product < ApplicationRecord
  has_one_attached :image
  belongs_to_active_hash :category
end