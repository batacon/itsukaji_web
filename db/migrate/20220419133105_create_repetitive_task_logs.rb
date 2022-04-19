class CreateRepetitiveTaskLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :repetitive_task_logs do |t|
      t.date :date, null: false
      t.references :repetitive_task, null: false, foreign_key: true

      t.timestamps
    end
  end
end
