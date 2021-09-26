Factorybot.define do
  factory :user do
    name { 'テストユーザー1' }
    email { 'test1@example.com' }
    password { 'password' }
  end
end