class Category < ApplicationRecord
  belongs_to :user
  has_many :costs, dependent: :destroy
  validates :name, presence: true, length: { minimum: 3 }
end
