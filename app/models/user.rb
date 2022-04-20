class User < ApplicationRecord
  belongs_to :group, class_name: 'UserGroup', foreign_key: 'group_id'

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  before_destroy :destroy_group, if: :owner?

  def owner?
    group.owner.id == self.id
  end

  private

  def destroy_group
    group.destroy!
  end
end
