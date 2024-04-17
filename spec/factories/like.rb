FactoryBot.define do 
    factory :like do
      association :account
      association :post
    end
  end
  