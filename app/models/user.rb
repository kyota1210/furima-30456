class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  NAME_REGEX = /\A[ぁ-んァ-ン一-龥]/.freeze
  NAME_KANA_REGEX = /\A[ァ-ヶー－]+\z/.freeze
  validates_format_of :password, with: PASSWORD_REGEX
  validates           :nickname, presence: true
  validates_format_of :first_name, presence: true, with: NAME_REGEX
  validates_format_of :last_name, presence: true, with: NAME_REGEX
  validates_format_of :read_first_name, presence: true, with: NAME_KANA_REGEX
  validates_format_of :read_last_name, presence: true, with: NAME_KANA_REGEX
  validates           :birthday, presence: true
end
