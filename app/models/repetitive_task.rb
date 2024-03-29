# frozen_string_literal: true

class RepetitiveTask < ApplicationRecord
  belongs_to :user_group

  has_many :logs, -> { order(date: :desc) }, class_name: 'RepetitiveTaskLog', dependent: :destroy
  has_many :task_create_logs, dependent: :destroy, class_name: 'ActivityLogs::TaskCreateLog'
  has_many :task_done_logs, dependent: :destroy, class_name: 'ActivityLogs::TaskDoneLog'

  validates :name, presence: true, length: { maximum: 20 }
  validates :interval_days, presence: true, numericality: { greater_than: 0, less_than: 1000 }

  scope :main_list_for_user, ->(user) { includes(:logs).where(user_group_id: user.group.id) }
  scope :sorted_array_by_due_date, -> { sort_by(&:days_until_next) }
  scope :search_by_name, lambda { |name_query|
    return all if name_query.blank?

    where('name LIKE ?', "%#{name_query}%")
  }

  def done_today?
    logs.where(date: Date.today).exists?
  end

  def today_log
    logs.find_by(date: Date.today)
  end

  def last_done_at
    @last_done_at ||= logs.order(date: :desc).first&.date
  end

  def reset_last_done_at
    @last_done_at = nil
  end

  def never_done?
    last_done_at.nil?
  end

  def days_since_last_done
    return 0 if never_done?

    (Date.today - last_done_at).to_i
  end

  def days_until_next
    return 0 if never_done?

    number_of_days = (interval_days - days_since_last_done).to_i
    number_of_days.negative? ? 0 : number_of_days
  end

  def should_do_today?
    days_until_next.zero?
  end
end
