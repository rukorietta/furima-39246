require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
   it 'usernameが空では登録できない' do
     user = User.new(username: '', email: 'test@example', password: '000000', password_confirmation: '000000', last_name: '田中', first_name: '太郎', last_name_kana: 'タナカ', first_name_kana: 'タロウ', birth_date: '1990-01-01')
     user.valid?
     expect(user.errors.full_messages).to include("Username can't be blank")
    end
   it 'emailが空では登録できない' do
     user = User.new(username: 'test', email: '', password: '000000', password_confirmation: '000000', last_name: '田中', first_name: '太郎', last_name_kana: 'タナカ', first_name_kana: 'タロウ', birth_date: '1990-01-01')
     user.valid?
     expect(user.errors.full_messages).to include("Email can't be blank")
   end
   it 'emailが一意性であること' do
     User.create(username: 'test1', email: 'test@example.com', password: '000000', password_confirmation: '000000', last_name: '田中', first_name: '太郎', last_name_kana: 'タナカ', first_name_kana: 'タロウ', birth_date: '1990-01-01')
     user = User.new(username: 'test2', email: 'test@example.com', password: '111111', password_confirmation: '111111', last_name: '田中', first_name: '太郎', last_name_kana: 'タナカ', first_name_kana: 'タロウ', birth_date: '1990-01-01')
     user.valid?
     expect(user.errors.full_messages).to include('Password is invalid')
   end
   it 'emailは、@を含む必要があること' do
     user = User.new(username: 'test', email: 'testexample.com', password: '000000', password_confirmation: '000000', last_name: '田中', first_name: '太郎', last_name_kana: 'タナカ', first_name_kana: 'タロウ', birth_date: '1990-01-01')
     user.valid?
     expect(user.errors.full_messages).to include('Email is invalid')
   end
   it 'パスワードが必須であること' do
     user = User.new(username: 'test', email: 'testexample.com', password: '', password_confirmation: '', last_name: '田中', first_name: '太郎', last_name_kana: 'タナカ', first_name_kana: 'タロウ', birth_date: '1990-01-01')
     user.valid?
     expect(user.errors.full_messages).to include("Password can't be blank")
   end
   it 'パスワードは、6文字以上での入力が必須であること' do
     user = User.new(username: 'test', email: 'testexample.com', password: '00000', password_confirmation: '00000', last_name: '田中', first_name: '太郎', last_name_kana: 'タナカ', first_name_kana: 'タロウ', birth_date: '1990-01-01')
     user.valid?
     expect(user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
   end
   it 'パスワードは、半角英数字混合での入力が必須であること' do
     user = User.new(username: 'test', email: 'testexample.com', password: 'password', password_confirmation: 'password', last_name: '田中', first_name: '太郎', last_name_kana: 'タナカ', first_name_kana: 'タロウ', birth_date: '1990-01-01')
     user.valid?
     expect(user.errors.full_messages).to include('Password is invalid')
   end
   it 'パスワードとパスワード（確認）は、値の一致が必須であること' do
     user = User.new(username: 'test', email: 'testexample.com', password: '000000', password_confirmation: '111111', last_name: '田中', first_name: '太郎', last_name_kana: 'タナカ', first_name_kana: 'タロウ', birth_date: '1990-01-01')
     user.valid?
     expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
   end
   it 'last_nameが空では登録できない' do
     user = User.new(username: 'test', email: 'test@example.com', password: '000000', password_confirmation: '000000', last_name: '', first_name: '太郎', last_name_kana: 'タナカ', first_name_kana: 'タロウ', birth_date: '1990-01-01')
     user.valid?
     expect(user.errors.full_messages).to include("Last name can't be blank")
   end
   it 'first_nameが空では登録できない' do
     user = User.new(username: 'test', email: 'test@example.com', password: '000000', password_confirmation: '000000', last_name: '田中', first_name: '', last_name_kana: 'タナカ', first_name_kana: 'タロウ', birth_date: '1990-01-01')
     user.valid?
     expect(user.errors.full_messages).to include("First name can't be blank")
   end
   it 'last_name_kanaが空では登録できない' do
     user = User.new(username: 'test', email: 'test@example.com', password: '000000', password_confirmation: '000000', last_name: '田中', first_name: '太郎', last_name_kana: '', first_name_kana: 'タロウ', birth_date: '1990-01-01')
     user.valid?
     expect(user.errors.full_messages).to include("Last name kana can't be blank")
   end
   it 'first_name_kanaが空では登録できない' do
     user = User.new(username: 'test', email: 'test@example.com', password: '000000', password_confirmation: '000000', last_name: '田中', first_name: '太郎', last_name_kana: 'タナカ', first_name_kana: '', birth_date: '1990-01-01')
     user.valid?
     expect(user.errors.full_messages).to include("First name kana can't be blank")
   end
   it 'birth_dateが空では登録できない' do
     user = User.new(username: 'test', email: 'test@example.com', password: '000000', password_confirmation: '000000', last_name: '田中', first_name: '太郎', last_name_kana: 'タナカ', first_name_kana: 'タロウ', birth_date: nil)
     user.valid?
     expect(user.errors.full_messages).to include("Birth date can't be blank")
   end
  end
end