# frozen_string_literal: true

class UserCreateFormSectionComponent < ViewComponent::Base
  def initialize(name:, email:, by_invitation: false, class_name: '')
    @name = name
    @email = email
    @by_invitation = by_invitation
    @class_name = class_name

    @heading = by_invitation ? '招待コードをお持ちの場合' : 'ひとりで使う、もしくは他の人を招待する場合'
    @submit_label = by_invitation ? '送信' : 'アカウント作成'
    @icon_name = by_invitation ? 'icon_group' : 'icon_solo'
  end

  private

  def by_invitation?
    @by_invitation
  end
end
