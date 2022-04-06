class RepetitiveTask < ApplicationRecord
  belongs_to :user
  has_many :logs, class_name: 'RepetitiveTaskLog', dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :user_id }, length: { maximum: 30 }
  validates :interval_days, presence: true, numericality: { greater_than: 0, less_than: 1000 }

  def done_today?
    logs.where(date: Date.today).exists?
  end

  def today_log
    logs.find_by(date: Date.today)
  end
end
