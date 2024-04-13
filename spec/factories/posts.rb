FactoryBot.define do 
   factory :post do
   image { File.open(File.join(Rails.root, '/spec/fixtures/img.jpg')) }
   description { FFaker::Book.title }
    association :account 
   end
end