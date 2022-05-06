class Cost < ApplicationRecord
  belongs_to :user
  belongs_to :category
  validates :name, presence: true, length: { minimum: 3 }
  validates :amount, presence: true, length: { minimum: 2 }
end
