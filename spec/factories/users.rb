FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    # email 'admin@test.com'
    password 'secret'
    password_confirmation 'secret'
    
    factory :admin do
      admin true
    end
  end
end
