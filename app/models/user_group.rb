# frozen_string_literal: true

class UserGroup < ApplicationRecord
  encrypts :invitation_code

  has_secure_token :invitation_code
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id', optional: true

  has_many :users, dependent: :destroy, foreign_key: 'group_id'
  has_many :repetitive_tasks, dependent: :destroy
  has_many :activity_logs, -> { order(:created_at) }, dependent: :destroy

  validates :owner_id, uniqueness: true

  def valid_invitation_code?(invitation_code)
    self.invitation_code == invitation_code
  end
end
