FactoryBot.define do
  factory :item do
    image            { Faker::Lorem.sentence }
    title            { Faker::Lorem.sentence(word_count: 40) }
    explanation      { Faker::Lorem.sentence(word_count: 1000) }
    category_id      { Faker::Number.between(from: 2, to: 11) }
    status_id        { Faker::Number.between(from: 2, to: 7) }
    transfer_fee_id  { Faker::Number.between(from: 2, to: 3) }
    from_address_id  { Faker::Number.between(from: 2, to: 48) }
    delivery_day_id  { Faker::Number.between(from: 2, to: 4) }
    price            { Faker::Number.between(from: 300, to: 9_999_999) }

    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
