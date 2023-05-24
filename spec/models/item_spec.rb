require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end
 
  describe '出品' do
   context '全ての機能が正しく入力できていれば' do
     it '出品できる' do
       expect(@item).to be_valid
     end
   end

   context '出品できない場合' do
     it 'imageが空だと出品できない' do
       @item.image = nil
       @item.valid?
       expect(@item.errors.full_messages).to include("画像を入力してください")
     end
  
      it 'nameが空だと出品できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end
  
      it 'descriptionの説明が空だと出品できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明を入力してください")
      end
  
      it 'category_idが1以外でないと出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーは1以外の値にしてください")
      end
  
      it 'condetion_idが1以外でないと出品できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態は1以外の値にしてください")
      end
  
      it 'delivery_fee_idが1以外でないと出品できない' do
        @item.delivery_fee_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担は1以外の値にしてください")
      end
  
      it 'prefecture_idが1以外でないと出品できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域は1以外の値にしてください")
      end
  
      it 'delivery_day_idが1以外でないと出品できない' do
        @item.delivery_day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数は1以外の値にしてください")
      end
  
      it 'priceが空では出品できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("値段を入力してください", "値段は数値で入力してください")
      end
  
      it 'priceが¥300未満では出品できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("値段は300円以上で設定してください")
      end

      it 'priceが¥10,000,000以上では出品できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include("値段は9,999,999円以下で設定してください")
      end
      
      it 'priceが半角数字でなければ出品できない' do
        @item.price = '１００００'
        @item.valid?
        expect(@item.errors.full_messages).to include("値段は数値で入力してください", "値段は300円以上で設定してください")
      end

      it 'ユーザーが紐づいていない場合出品できない' do
        item = FactoryBot.build(:item, user_id: nil)
        item.valid?
        expect(item.errors.full_messages).to include("Userを入力してください")
      end
    end
  end
end