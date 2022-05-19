# frozen_string_literal: true

class AddRememberTokenToUsers < ActiveRecord::Migration[7.0]
  def up
    add_column :users, :remember_token, :string

    User.where(remember_token: nil).find_each(&:regenerate_remember_token)

    change_column_null :users, :remember_token, false
  end

  def down
    remove_column :users, :remember_token
  end
end
