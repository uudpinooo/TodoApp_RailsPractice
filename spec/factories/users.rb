FactoryBot.define do
  factory :user do
    name { 'ユーザー名' }
    email { 'test@example.com' }
    password { 'password' }
  end
end