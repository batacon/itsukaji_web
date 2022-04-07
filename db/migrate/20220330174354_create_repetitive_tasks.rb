class CreateRepetitiveTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :repetitive_tasks do |t|
      t.string :name, null: false
      t.integer :interval_days, null: false
      t.integer :days_until_next, null: false, default: 0
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end