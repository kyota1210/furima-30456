FactoryBot.define do
  factory :user do
    nickname              {Faker::Name.initials}
    email                 {Faker::Internet.free_email}
    password              {Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
    first_name            {Gimei::first.kanji}
    last_name             {Gimei::last.kanji}
    read_first_name       {Gimei::first.katakana}
    read_last_name        {Gimei::last.katakana}
    birthday              {Faker::Date.between(from: '1930-01-01', to: '2015-12-31')}
  end
end