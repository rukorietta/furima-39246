require 'faker'

FactoryBot.define do
  factory :order_form do
    transient do
      person { Gimei.name }
    end
    postal_code { '123-4567' }
    prefecture_id { 1 }
    city { 'テスト市' }
    address { 'テスト1-1-1' }
    building_name { 'テストビル' }
    phone_number { '09012345678' }
    token { 'sample_token' }
    
    trait :invalid do
      postal_code { '' }
    end
  end
end

