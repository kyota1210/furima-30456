class Item < ApplicationRecord
  
  PRICE_REGEX = /\A[0-9]+\z/.freeze
  with_options presence: true do
    validates :image
    validates :title
    validates :explanation
    validates :category_id,     numericality: {other_than: 1}
    validates :status_id,       numericality: {other_than: 1}
    validates :transfer_fee_id, numericality: {other_than: 1}
    validates :from_address_id, numericality: {other_than: 1}
    validates :delivery_day_id, numericality: {other_than: 1}
    validates :price,           numericality: {greater_than_or_equal_to: 300, less_than: 10000000}, format: {with: PRICE_REGEX}
  end

  belongs_to :user
  has_one_attached :image
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :status 
  belongs_to_active_hash :transfer_fee
  belongs_to_active_hash :from_address
  belongs_to_active_hash :delivery_day

end
