class Cost < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :category
  validates :name, presence: true, length: { minimum: 3 }
  validates :amount, presence: true, length: { minimum: 2 }
end
