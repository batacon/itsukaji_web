# frozen_string_literal: true

class RepetitiveTaskLog < ApplicationRecord
  belongs_to :repetitive_task

  validates :date, presence: true, uniqueness: { scope: :repetitive_task_id }
  validate :date_cannot_be_in_the_future

  after_create :update_last_done_at

  def how_many_days_ago
    (Date.today - date).to_i
  end

  def previous_log_date
    return if self_index == same_task_logs.count - 1

    same_task_logs[self_index + 1]&.date
  end

  def next_log_date
    return if self_index.zero?

    same_task_logs[self_index - 1]&.date
  end

  private

  def update_last_done_at
    repetitive_task.reset_last_done_at
  end

  def date_cannot_be_in_the_future
    return if date.blank? || date <= Date.today

    errors.add(:date, 'は今日以前の日付を指定してください')
  end

  def self_index
    @index = same_task_logs.ids.index(id)
  end

  def same_task_logs
    @logs = repetitive_task.logs
  end
end
