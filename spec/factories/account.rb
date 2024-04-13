FactoryBot.define do
  factory :account do
    username { FFaker::Name.name }
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    email { FFaker::Internet.safe_email }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
