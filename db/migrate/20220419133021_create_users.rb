# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false, unique: true
      t.references :group, null: false, foreign_key: { to_table: :user_groups }

      t.timestamps
    end
  end
end
