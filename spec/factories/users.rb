require 'faker'

FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
    end
    email { Faker::Internet.unique.email }
    password { 'itti12' }
    first_name { person.first.kanji.mb_chars }
    last_name { person.last.kanji.mb_chars }
    first_name_kana { person.first.katakana.mb_chars }
    last_name_kana { person.last.katakana.mb_chars }
    birth_date { Faker::Date.birthday(min_age: 18, max_age: 65) }
    username { Faker::Internet.username(specifier: 5..8) }
  end
end