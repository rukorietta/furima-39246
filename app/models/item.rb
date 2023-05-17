class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :user

  def sold_out?
    # 売り切れているかどうかのロジックを記述する
    # 例えば、在庫数が0の場合に売り切れと判定するなど
  end
  

  validates :image, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { only_integer: true }
  validates :category_id, numericality: { other_than: 1 }
  validates :condition_id, numericality: { other_than: 1 } 
  validates :delivery_fee_id, numericality: { other_than: 1 } 
  validates :prefecture_id, numericality: { other_than: 1 } 
  validates :delivery_day_id, numericality: { other_than: 1 } 

  # ActiveHashのバリデーション
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :condition
  belongs_to_active_hash :category
  belongs_to_active_hash :delivery_fee
  belongs_to_active_hash :delivery_day
  belongs_to_active_hash :prefecture

  # カスタムバリデーション
  validate :price_must_be_greater_than_or_equal_to_300
  validate :price_must_be_less_than_or_equal_to_9_999_999

  private

  # 商品価格が300円以上であることをバリデーションする
  def price_must_be_greater_than_or_equal_to_300
    errors.add(:price, "は300円以上で設定してください") if price.present? && price < 300
  end

  # 商品価格が9,999,999円以下であることをバリデーションする
  def price_must_be_less_than_or_equal_to_9_999_999
    errors.add(:price, "は9,999,999円以下で設定してください") if price.present? && price > 9_999_999
  end

end 