# frozen_string_literal: true

class CreateActivityLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :activity_logs do |t|
      t.string :loggable_type, null: false
      t.bigint :loggable_id, null: false
      t.references :user, null: false, foreign_key: true
      t.references :user_group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
