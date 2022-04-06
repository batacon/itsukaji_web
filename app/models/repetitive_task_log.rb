class RepetitiveTaskLog < ApplicationRecord
  belongs_to :repetitive_task

  validates :date, presence: true, uniqueness: { scope: :repetitive_task_id }
end
