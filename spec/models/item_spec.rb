require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品を出品する' do
    context '商品が出品できるとき' do
      it '商品画像、商品名、商品説明、カテゴリー、商品状態、配送料負担、発送元地域、発送までの日数、価格についての情報が存在すれば出品できる' do
        expect(@item).to be_valid
      end
    end

    context '商品が出品できないとき' do
      it '商品画像がなければ出品できないこと' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("出品画像を入力してください")
      end
      it '商品名がなければ出品できないこと' do
        @item.title = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end
      it '商品説明がなければ出品できないこと' do
        @item.explanation = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明を入力してください")
      end
      it 'カテゴリー情報がなければ出品できないこと' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーが選択されていません")
      end
      it 'カテゴリー情報で、1が選択されていると出品できないこと' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーが選択されていません")
      end
      it '商品の状態についての情報がなければ出品できないこと' do
        @item.status_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態が選択されていません")
      end
      it '商品状態についての情報で、1が選択されていると出品できないこと' do
        @item.status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態が選択されていません")
      end
      it '配送料の負担についての情報がなければ出品できないこと' do
        @item.transfer_fee_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担が選択されていません")
      end
      it '配送料の負担についての情報で、1が選択されていると出品できないこと' do
        @item.transfer_fee_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担が選択されていません")
      end
      it '発送元の地域の情報がなければ出品できないこと' do
        @item.from_address_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域が選択されていません")
      end
      it '発送元の地域についての情報で、1が選択されていると出品できないこと' do
        @item.from_address_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域が選択されていません")
      end
      it '発送までの日数についての情報がなければ出品できなこと' do
        @item.delivery_day_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数が選択されていません")
      end
      it '発送までの日数についての情報で、1が選択されていると出品できないこと' do
        @item.delivery_day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数が選択されていません")
      end
      it '価格についての情報がなければ出品できないこと' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("価格を入力してください")
      end
      it '価格が299円以下の場合、出品できないこと' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は¥300~9,999,999で入力してください")
      end
      it '価格が10,000,000円以上の場合、出品できないこと' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は¥300~9,999,999で入力してください")
      end
      it '価格が半角数字で入力されてなければ出品できないこと' do
        @item.price = '５００'
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は¥300~9,999,999で入力してください")
      end
      it 'ユーザーに紐付いていなければ出品できないこと' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Userを入力してください")
      end
    end
  end
end
