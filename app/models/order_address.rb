class OrderAddress
  include ActiveModel::Model
  attr_accessor :token, :user_id, :item_id, :zip_code, :prefecture_id, :city, :address_number, :building_name, :phone_number

  ZIP_CODE_REGEX = /\A\d{3}[-]\d{4}\z/.freeze
  MOBILE_REGEX = /\A\d{11}\z/.freeze
  with_options presence: true do
    validates :token
    validates :user_id
    validates :item_id
    validates :zip_code,      format: { with: ZIP_CODE_REGEX, message: 'はハイフンを含めて入力してください' }
    validates :prefecture_id, numericality: { other_than: 1, message: 'が選択されていません' }
    validates :city
    validates :address_number
    validates :phone_number, format: { with: MOBILE_REGEX, message: 'が正しく入力されていません' }
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(zip_code: zip_code, prefecture_id: prefecture_id, city: city,
                   address_number: address_number, building_name: building_name, phone_number: phone_number, order_id: order.id)
  end
end
