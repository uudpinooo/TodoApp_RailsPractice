FactoryBot.define do
  factory :task do
    name { 'タスク名' }
    description { 'タスクの説明を書く' }
    user
  end
end