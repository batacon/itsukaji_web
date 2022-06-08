# frozen_string_literal: true

namespace :task_reminder do
  desc '未完了タスクのあるユーザー全員にPush通知を送信する'
  task remind_todo_today: :environment do
    target_users = User.all.filter do |user|
      user.group.repetitive_tasks.any?(&:should_do_today?)
    end
    target_user_ids = target_users.map(&:id)

    CreateNotification.new(
      contents: { 'en' => 'There are tasks to be done.', 'ja' => 'そろそろやるべきタスクがあります！' },
      target_user_ids:
    ).call
  end

  desc '明日やるべきになるタスクがあるユーザー全員にPush通知を送信する'
  task remind_todo_tomorrow: :environment do
    target_users = User.all.filter do |user|
      user.group.repetitive_tasks.any? do |task|
        task.days_until_next == 1
      end
    end
    target_user_ids = target_users.map(&:id)

    CreateNotification.new(
      contents: { 'en' => 'There are tasks to be done tomorrow.', 'ja' => '明日やるべきになるタスクがあります！' },
      target_user_ids:
    ).call
  end
end
