# frozen_string_literal: true

class WithdrawButtonComponent < ViewComponent::Base
  MESSAGE_FOR_GROUP_OWNER = <<~MESSAGE
    注意！！オーナーであるあなたが退会すると、グループごと削除され、
    タスクを共有しているグループ内のユーザー全員も退会します。
    登録したタスクに関するデータはすべて削除され、復元できません。

    本当にグループを解散して退会しますか？
  MESSAGE

  MESSAGE_FOR_SINGLE_OWNER = <<~MESSAGE
    <<~MESSAGE
    注意！！退会すると、登録したタスクに関するデータはすべて削除され、復元できません。

    本当に退会しますか？
  MESSAGE

  MESSAGE_FOR_MEMBER = <<~MESSAGE
    注意！！退会すると、あなたによるアクティビティログはすべて削除され、復元できません。
    もう一度グループに入り直す場合は、再度招待コードを入力する必要があります。

    本当に退会しますか？
  MESSAGE

  def initialize(label:, current_user:, class_name: '')
    @label = label
    @current_user = current_user
    @class_name = class_name
  end

  private

  def confirm_message
    if @current_user.owner? && @current_user.group.users.count > 1
      MESSAGE_FOR_GROUP_OWNER
    elsif @current_user.owner?
      MESSAGE_FOR_SINGLE_OWNER
    else
      MESSAGE_FOR_MEMBER
    end
  end

  def deletion_target_path
    return  user_group_path(@current_user.group) if @current_user.owner?

    user_path(@current_user)
  end
end
