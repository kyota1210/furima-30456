FactoryBot.define do
  factory :order_address do
    token           { 'tok_abcdefghijklmnopqrstu0000000' }
    zip_code        { '123-4567' }
    prefecture_id   { Faker::Number.between(from: 2, to: 48) }
    city            { '大阪市' }
    address_number  { '1-23' }
    building_name { '柳丸ハイツ' }
    phone_number { Faker::Number.number(digits: 11) }
  end
end
