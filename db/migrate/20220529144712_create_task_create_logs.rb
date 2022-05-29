# frozen_string_literal: true

class CreateTaskCreateLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :task_create_logs do |t|
      t.references :repetitive_task, null: false, foreign_key: true

      t.timestamps
    end
  end
end
