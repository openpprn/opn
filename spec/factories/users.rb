FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user_email_#{n}@example.com"}
    password "my_password"
  end

  factory :admin do

  end

  factory :owner do

  end
end