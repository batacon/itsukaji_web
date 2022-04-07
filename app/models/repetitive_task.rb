class RepetitiveTask < ApplicationRecord
  belongs_to :user
  has_many :logs, class_name: 'RepetitiveTaskLog', dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :user_id }, length: { maximum: 30 }
  validates :interval_days, presence: true, numericality: { greater_than: 0, less_than: 1000 }
  validates :days_until_next, numericality: { greater_than_or_equal_to: 0, less_than: 1000 }

  def done_today?
    logs.where(date: Date.today).exists?
  end

  def today_log
    logs.find_by(date: Date.today)
  end

  def last_done_at
    logs.order(date: :desc).first&.date
  end

  def never_done?
    last_done_at.nil?
  end

  def days_since_last_done
    return 0 if never_done?

    (Date.today - last_done_at).to_i
  end

  def number_of_days_until_next
    return 0 if never_done?

    (interval_days - days_since_last_done).to_i
  end
end
