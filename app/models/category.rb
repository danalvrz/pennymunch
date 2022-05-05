class Category < ApplicationRecord
  belongs_to :user
  has_many :costs, dependent: :destroy
  validates :name, presence: true, length: { minimum: 3 }
  validates :icon, presence: true, length: { minimum: 1, maximum: 1 }

  def transaction_sum
    return Cost.includes(:category).where(category_id: id).sum(:amount) unless Category.all.nil?

    0
  end
end
