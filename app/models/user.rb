class User < ApplicationRecord
  belongs_to :group, class_name: 'UserGroup', foreign_key: 'group_id'

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

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

    private

    def valid_invitation?(inviter, invitation_code)
      inviter && inviter.owner? && inviter.group.valid_invitation_code?(invitation_code)
    end
  end

  def owner?
    group.owner.id == self.id
  end

  def able_to_destroy?(target_user)
    owner? && target_user.id != self.id  && target_user.member_of?(group)
  end

  def member_of?(group)
    group.users.include?(self)
  end
end
