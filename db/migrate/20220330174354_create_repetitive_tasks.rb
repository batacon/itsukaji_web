class CreateRepetitiveTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :repetitive_tasks do |t|
      t.string :name, null: false, unique: true
      t.integer :interval, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
