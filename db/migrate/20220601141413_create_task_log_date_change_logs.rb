# frozen_string_literal: true

class CreateTaskLogDateChangeLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :task_log_date_change_logs do |t|
      t.date :from, null: false
      t.date :to, null: false
      t.references :repetitive_task, null: false, foreign_key: true

      t.timestamps
    end
  end
end
