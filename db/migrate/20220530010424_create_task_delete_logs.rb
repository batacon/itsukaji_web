# frozen_string_literal: true

class CreateTaskDeleteLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :task_delete_logs do |t|
      t.string :task_name, null: false

      t.timestamps
    end
  end
end
