class RepetitiveTaskLog < ApplicationRecord
  belongs_to :repetitive_task

  validates :date, presence: true, uniqueness: { scope: :repetitive_task_id }

  after_create :update_last_done_at

  def how_many_days_ago
    (Date.today - self.date).to_i
  end

  private

  def update_last_done_at
    repetitive_task.reset_last_done_at
  end
end
