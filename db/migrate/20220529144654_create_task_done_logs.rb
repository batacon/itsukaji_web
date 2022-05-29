# frozen_string_literal: true

class CreateTaskDoneLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :task_done_logs do |t|
      t.references :repetitive_task, null: false, foreign_key: true

      t.timestamps
    end
  end
end
