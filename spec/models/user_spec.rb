require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    context '正常な場合' do
      before do
        @user = FactoryBot.build(:user)
      end
      
      it 'ユーザーを登録できること' do
        expect(@user).to be_valid
      end
    end

    context '異常な場合' do
      before do
        @existing_user = FactoryBot.create(:user)
        @user = FactoryBot.build(:user, email: @existing_user.email)
      end
      it 'usernameが空では登録できない' do
        @user.username = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Username can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
     end
      it 'emailが一意性であること' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
     it 'emailは、@を含む必要があること' do
       @user.email = 'testexample.com'
       @user.valid?
       expect(@user.errors.full_messages).to include('Email is invalid')
     end
     it 'パスワードが必須であること' do
       @user.password = ''
       @user.valid?
       expect(@user.errors.full_messages).to include("Password can't be blank")
     end
      it 'パスワードは、6文字以上での入力が必須であること' do
       @user.password = 'a' * 5
       @user.valid?
       expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
     end
     it 'パスワードは、半角英数字混合での入力が必須であること' do
       @user.password = 'password'
       @user.password_confirmation = 'password'
       @user.valid?
       expect(@user.errors.full_messages).to include('Password is invalid')
     end
     it 'パスワードとパスワード（確認）は、値の一致が必須であること' do
       @user.password_confirmation = '111111'
       @user.valid?
       expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
     end
     it 'last_nameが空では登録できない' do
       @user.last_name = ''
       @user.valid?
       expect(@user.errors.full_messages).to include("Last name can't be blank")
     end
     it 'first_nameが空では登録できない' do
       @user.first_name = ''
       @user.valid?
       expect(@user.errors.full_messages).to include("First name can't be blank")
     end
     it 'last_name_kanaが空では登録できない' do
       @user.last_name_kana = ''
       @user.valid?
       expect(@user.errors.full_messages).to include("Last name kana can't be blank")
     end
     it 'first_name_kanaが空では登録できない' do
       @user.first_name_kana = ''
       @user.valid?
       expect(@user.errors.full_messages).to include("First name kana can't be blank")
     end
     it 'birth_dateが空では登録できない' do
       @user.birth_date = ''
       @user.valid?
       expect(@user.errors.full_messages).to include("Birth date can't be blank")
     end
   end
 end
end