# frozen_string_literal: true

class User < ApplicationRecord
  encrypts :name
  encrypts :email, deterministic: true
  encrypts :remember_token

  has_secure_token :remember_token

  belongs_to :group, class_name: 'UserGroup', foreign_key: 'group_id'
  has_many :activity_logs, -> { order(created_at: :desc) }, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  before_create :set_last_check_activity_logs_at

  after_create :create_activity_logs_for_group_member_added_log

  class << self
    def create_by_invitation(user_params, invitation_params)
      inviter = User.find_by(email: invitation_params[:inviter_email])
      return false unless valid_invitation?(inviter, invitation_params[:invitation_code])

      create!(user_params.merge(group_id: inviter.group_id))
    end

    def create_with_group_as_owner!(user_params)
      ActiveRecord::Base.transaction do
        new_group = UserGroup.create!
        user = create!(user_params.merge(group_id: new_group.id))
        new_group.update!(owner_id: user.id)
        user
      end
    end

    def find_and_authenticate(user_id, remember_token)
      user = find_by(id: user_id)
      return false unless user&.authenticated?(remember_token)

      user
    end

    private

    def valid_invitation?(inviter, invitation_code)
      inviter&.owner? && inviter.group.valid_invitation_code?(invitation_code)
    end
  end

  def owner?
    group.owner.id == id
  end

  def able_to_destroy?(target_user)
    owner? && target_user.id != id && target_user.member_of?(group)
  end

  def member_of?(group)
    group.users.include?(self)
  end

  def authenticated?(remember_token)
    self.remember_token == remember_token
  end

  def activity_to_highlight_exists?
    group.activity_logs.should_highlight_for(self).exists?
  end

  private

  def set_last_check_activity_logs_at
    self.last_check_activity_logs_at = Time.zone.now
  end

  def create_activity_logs_for_group_member_added_log
    ActivityLog.create!(
      user_group: group,
      user: self,
      loggable: ActivityLogs::GroupMemberAddedLog.new
    )
  end
end
