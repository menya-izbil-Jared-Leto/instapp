FactoryBot.define do 
    factory :comment do
      comment { FFaker::Book.title }
      association :account
      association :post
    end
  end
  