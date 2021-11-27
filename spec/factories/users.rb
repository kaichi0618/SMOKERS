FactoryBot.define do
  factory :user do
    email {Faker::Internet.free_email}
    password = Faker::Internet.password(min_length: 6)
    password {password}
    password_confirmation {password}
    last_name { "山田" }
    first_name {"太郎"}
    nickname {"たろちゃん"}
  end
end
