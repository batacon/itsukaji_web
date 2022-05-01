# frozen_string_literal: true

require "test_helper"

class InvitationCodeComponentTest < ViewComponent::TestCase
  it 'current_userがownerである場合、正しく表示される' do
    current_user = users(:owner1)
    render_inline(InvitationCodeComponent.new(current_user:))
    assert_text current_user.group.invitation_code
  end

  it 'current_userがownerでない場合、表示されない' do
    current_user = users(:member1_of_group1)
    render_inline(InvitationCodeComponent.new(current_user:))
    assert_no_text current_user.group.invitation_code
  end
end
