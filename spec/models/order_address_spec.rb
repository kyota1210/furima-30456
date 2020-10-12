require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    @order_address = FactoryBot.build(:order_address)
  end

  it 'すべての値が正しく入力されていれば保存できること' do
    expect(@order_address).to be_valid
  end
  it 'tokenが空では保存できないこと' do
    @order_address.token = ''
    @order_address.valid?
    expect(@order_address.errors.full_messages).to include("Token can't be blank")
  end
  it '郵便番号が空では保存できないこと' do
    @order_address.zip_code = ''
    @order_address.valid?
    expect(@order_address.errors.full_messages).to include("Zip code can't be blank")
  end
  it '郵便番号にハイフンが無ければ保存できないこと' do
    @order_address.zip_code = 1_234_567
    @order_address.valid?
    expect(@order_address.errors.full_messages).to include('Zip code is invalid')
  end
  it '都道府県の情報が空では保存できないこと' do
    @order_address.prefecture_id = ''
    @order_address.valid?
    expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
  end
  it '都道府県の情報で1が選択されていると保存できないこと' do
    @order_address.prefecture_id = 1
    @order_address.valid?
    expect(@order_address.errors.full_messages).to include('Prefecture must be other than 1')
  end
  it '市区町村が空では保存できないこと' do
    @order_address.city = ''
    @order_address.valid?
    expect(@order_address.errors.full_messages).to include("City can't be blank")
  end
  it '番地が空では保存できないこと' do
    @order_address.address_number = ''
    @order_address.valid?
    expect(@order_address.errors.full_messages).to include("Address number can't be blank")
  end
  it '建物名は空でも保存できること' do
    @order_address.building_name = ''
    expect(@order_address).to be_valid
  end
  it '電話番号が空では保存できないこと' do
    @order_address.phone_number = ''
    @order_address.valid?
    expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
  end
  it '電話番号にハイフンがあると保存できないこと' do
    @order_address.phone_number = '090-1234-5678'
    @order_address.valid?
    expect(@order_address.errors.full_messages).to include('Phone number is invalid')
  end
  it '電話番号が11桁でなければ保存できないこと' do
    @order_address.phone_number = '1234567890'
    @order_address.valid?
    expect(@order_address.errors.full_messages).to include('Phone number is invalid')
  end
end
