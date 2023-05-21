FactoryBot.define do
  factory :shipping do
    order { nil }
    postal_code { "MyString" }
    prefecture_id { 1 }
    city { "MyString" }
    address { "MyString" }
    building_name { "MyString" }
    phone_number { "MyString" }
  end
end
