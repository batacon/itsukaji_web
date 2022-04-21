class User < ApplicationRecord
  belongs_to :group, class_name: 'UserGroup', foreign_key: 'group_id'

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  before_destroy :destroy_group, if: :owner?

  class << self
    def create_with_group!(user_params)
      ActiveRecord::Base.transaction do
        new_group = UserGroup.create!
        user = create!(user_params.merge(group_id: new_group.id))
        new_group.update!(owner_id: user.id)
        user
      end
    end
  end

  def owner?
    group.owner.id == self.id
  end

  private

  def destroy_group
    group.destroy!
  end
end
