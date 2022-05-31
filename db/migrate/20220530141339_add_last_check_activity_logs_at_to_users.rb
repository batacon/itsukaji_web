class AddLastCheckActivityLogsAtToUsers < ActiveRecord::Migration[7.0]
  def up
    add_column :users, :last_check_activity_logs_at, :datetime

    User.where(last_check_activity_logs_at: nil).find_each do |user|
      user.update!(last_check_activity_logs_at: Time.zone.now)
    end

    change_column_null :users, :last_check_activity_logs_at, false
  end

  def down
    remove_column :users, :last_check_activity_logs_at
  end
end
