class CreateUserGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :user_groups do |t|
      t.bigint :owner_id

      t.timestamps
    end
  end
end
