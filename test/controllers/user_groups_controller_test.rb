# frozen_string_literal: true

require 'test_helper'

class UserGroupsControllerTest < ActionDispatch::IntegrationTest
  let(:user_group) { user_groups(:one) }

  describe 'ログイン時' do
    before { create_user_and_log_in }

    describe 'index' do
      it 'ユーザーグループ画面を正しく表示' do
        get user_groups_path
        assert_response :success
      end
    end

    describe 'update' do
      it 'ユーザーグループの招待コードを更新し、ユーザーグループ画面にリダイレクト' do
        old_invitation_code = user_group.invitation_code
        put user_group_path(user_group)
        expect(user_group.reload.invitation_code).wont_equal old_invitation_code
        assert_redirected_to user_groups_path
      end
    end

    describe 'destroy' do
      it 'ユーザーグループを削除し、トップページにリダイレクト' do
        expect(user_group.users.count).must_equal 3 # owner, member1_of_group1, member2_of_group1
        assert_difference 'UserGroup.count', -1 do
          assert_difference 'User.count', -3 do
            delete user_group_path(user_group)
          end
        end
        assert_redirected_to root_path
      end
    end
  end

  describe 'ログアウト時' do
    describe 'index' do
      it 'トップページにリダイレクト' do
        get user_groups_path
        assert_redirected_to root_url
      end
    end

    describe 'update' do
      it 'トップページにリダイレクト' do
        put user_group_path(user_group), params: { user_group: { name: 'test2' } }
        assert_redirected_to root_url
      end
    end

    describe 'destroy' do
      it 'トップページにリダイレクト' do
        delete user_group_path(user_group)
        assert_redirected_to root_url
      end
    end
  end
end
