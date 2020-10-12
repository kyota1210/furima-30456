class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  NAME_REGEX = /\A[ぁ-んァ-ン一-龥]/.freeze
  NAME_KANA_REGEX = /\A[ァ-ヶー－]+\z/.freeze

  validates_format_of :password, with: PASSWORD_REGEX
  with_options presence: true do
    validates           :nickname
    validates           :first_name, format: { with: NAME_REGEX }
    validates           :last_name, format: { with: NAME_REGEX }
    validates           :read_first_name, format: { with: NAME_KANA_REGEX }
    validates           :read_last_name, format: { with: NAME_KANA_REGEX }
    validates           :birthday
  end

  has_many :items
  has_many :orders
end
