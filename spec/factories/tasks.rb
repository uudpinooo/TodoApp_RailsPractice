Factorybot.define do
  factory :task do
    name { 'テストを書く' }
    description { 'RSpec, Capybara, Factorybotでテストを書く' }
    user
  end
end