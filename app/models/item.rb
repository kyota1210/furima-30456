class Item < ApplicationRecord
  belongs_to :user
  has_one :order
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :status
  belongs_to_active_hash :transfer_fee
  belongs_to_active_hash :from_address
  belongs_to_active_hash :delivery_day

  PRICE_REGEX = /\A[0-9]+\z/.freeze
  with_options presence: true do
    validates :image
    validates :title
    validates :explanation
    validates :category_id,     numericality: { other_than: 1, message: 'が選択されていません' }
    validates :status_id,       numericality: { other_than: 1, message: 'が選択されていません' }
    validates :transfer_fee_id, numericality: { other_than: 1, message: 'が選択されていません' }
    validates :from_address_id, numericality: { other_than: 1, message: 'が選択されていません' }
    validates :delivery_day_id, numericality: { other_than: 1, message: 'が選択されていません' }
    validates :price,           numericality: { greater_than_or_equal_to: 300, less_than: 10_000_000, message: 'は¥300~9,999,999で入力してください' },
                                format: { with: PRICE_REGEX, message: 'は半角数字で入力してください' }
  end
end
