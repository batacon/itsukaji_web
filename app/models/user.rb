class User < ApplicationRecord
  belongs_to :group, class_name: 'UserGroup', foreign_key: 'group_id'

  class << self
    def find_or_create_from_auth_hash!(auth_hash)
      user_params = user_params_from_auth_hash(auth_hash)
      find_or_create_by!(email: user_params[:email]) do |user|
        group = UserGroup.create!
        user.update!(user_params.merge(group_id: group.id))
        group.update!(owner_id: user.id)
      end
    end

    private

    def user_params_from_auth_hash(auth_hash)
      {
        name: auth_hash.info.name,
        email: auth_hash.info.email,
      }
    end
  end
end
