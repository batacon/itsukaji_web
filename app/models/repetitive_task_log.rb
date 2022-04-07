class RepetitiveTaskLog < ApplicationRecord
  belongs_to :repetitive_task

  validates :date, presence: true, uniqueness: { scope: :repetitive_task_id }

  after_save :update_days_until_next

  def how_many_days_ago
    (Date.today - self.date).to_i
  end

  private

  def update_days_until_next
    task = self.repetitive_task
    task.update!(days_until_next: task.number_of_days_until_next)
  end
end
