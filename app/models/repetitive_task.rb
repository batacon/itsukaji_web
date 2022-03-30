class RepetitiveTask < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, uniqueness: { scope: :user_id }
  validates :interval_days, presence: true, numericality: { greater_than: 0 }
end
