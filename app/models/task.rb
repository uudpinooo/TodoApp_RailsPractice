class Task < ApplicationRecord
  validates :name, presence: true, length: {maximum: 50}
  validates :description, length: {maximum: 1000}

  belongs_to :user
end
