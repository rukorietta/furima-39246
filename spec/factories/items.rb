require 'faker'

FactoryBot.define do
  factory :item do
    transient do
      person { Gimei.name }
    end
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.sentence }
    category_id { 2 } # カテゴリーに対応するIDを設定
    condition_id { 2 } # 商品の状態に対応するIDを設定
    delivery_fee_id { 2 } # 配送料の負担に対応するIDを設定
    prefecture_id { 2 } # 発送元の地域に対応するIDを設定
    delivery_day_id { 2 } # 発送までの日数に対応するIDを設定
    price { Faker::Number.within(range: 300..9999999) } # 300円から9999999円の範囲でランダムな価格を設定
    association :user 

    after(:build) do |item|
      item.image.attach(io: File.open('app/assets/images/item-sample.png'), filename: 'item-sample.png')
    end
  end
end