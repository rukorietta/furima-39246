require 'rails_helper'

RSpec.describe OrderForm, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item, user: @user)
    @order_form = FactoryBot.build(:order_form, user_id: @user.id, item_id: @item.id)
  end

  describe '購入' do
    context '全ての機能が正しく入力できていれば' do
      it '購入できる' do
        expect(@order_form).to be_valid
      end
    end

    context '購入できない場合' do
      it 'postal_codeが空だと購入できない' do
        @order_form.postal_code = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("郵便番号を入力してください")
      end

      it 'postal_codeが「3桁ハイフン4桁」の形式でないと購入できない' do
        @order_form.postal_code = '1234567'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("郵便番号は「3桁ハイフン4桁」の形式で入力してください")
      end

      it 'prefecture_idが空だと購入できない' do
        @order_form.prefecture_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("都道府県を入力してください")
      end

      it 'cityが空だと購入できない' do
        @order_form.city = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("市区町村を入力してください")
      end

      it 'addressが空だと購入できない' do
        @order_form.address = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("番地を入力してください")
      end

      it 'phone_numberが空だと購入できない' do
        @order_form.phone_number = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("電話番号を入力してください")
      end

      it 'phone_numberが9桁以下では購入できない' do
        @order_form.phone_number = '123456789' # 9桁の電話番号
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("電話番号は10桁以上11桁以内の半角数値で入力してください")
      end
      
      it 'phone_numberが12桁以上では購入できない' do
        @order_form.phone_number = '123456789012' # 12桁の電話番号
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("電話番号は10桁以上11桁以内の半角数値で入力してください")
      end

      it 'tokenが空だと購入できない' do
        @order_form.token = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("トークンを入力してください")
      end
      
      it '電話番号に半角数字以外が含まれている場合は購入できない' do
        @order_form.phone_number = '090a1234567' # 半角数字以外が含まれている
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("電話番号は10桁以上11桁以内の半角数値で入力してください")
      end
      
      it 'userが紐付いていなければ購入できない' do
        @order_form.user_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Userを入力してください")
      end
      
      it 'itemが紐付いていなければ購入できない' do
        @order_form.item_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Itemを入力してください")
      end
    end
  end
end