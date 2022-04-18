class RepetitiveTaskLog < ApplicationRecord
  belongs_to :repetitive_task

  validates :date, presence: true, uniqueness: { scope: :repetitive_task_id }

  def how_many_days_ago
    (Date.today - self.date).to_i
  end
end
