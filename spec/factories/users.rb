require 'faker'

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    username { Faker::Name.unique.name }
    password { "password" }
  end
end