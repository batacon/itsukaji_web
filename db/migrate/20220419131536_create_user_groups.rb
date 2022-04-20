class CreateUserGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :user_groups do |t|
      t.bigint :owner_id
      t.string :invitation_code

      t.timestamps
    end
    add_index :user_groups, :invitation_code, unique: true
  end
end
