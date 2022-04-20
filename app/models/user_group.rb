class UserGroup < ApplicationRecord
  has_secure_token :invitation_code
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id', optional: true

  has_many :users, dependent: :destroy, foreign_key: 'group_id'
  has_many :repetitive_tasks, dependent: :destroy
end
