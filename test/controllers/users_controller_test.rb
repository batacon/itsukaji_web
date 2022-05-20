# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  describe 'create' do
    let(:user_params) { { name: 'test', email: 'eee@gmail.com' } }

    describe '招待されている場合' do
      let(:owner) { users(:owner1) }

      it 'ユーザーを作成し、ログインしてタスク一覧画面にリダイレクト' do
        invitation_params = { invitation_code: owner.group.invitation_code, inviter_email: owner.email }

        assert_difference 'owner.group.users.count', 1 do
          assert_difference 'UserGroup.count', 0 do
            post users_path, params: user_params.merge(invitation_params)
          end
        end
        assert_redirected_to repetitive_tasks_path
      end

      it 'emailでユーザーが見つからない場合は、ユーザーは作成されず、welcomeページにリダイレクト' do
        invitation_params = { invitation_code: owner.group.invitation_code, inviter_email: 'unknown@unknown.com' }
        assert_difference 'owner.group.users.count', 0 do
          assert_difference 'UserGroup.count', 0 do
            post users_path, params: user_params.merge(invitation_params)
          end
        end
        assert_redirected_to welcome_path(user: user_params)
      end

      it 'emailがオーナーのemailでない場合は、ユーザーは作成されず、welcomeページにリダイレクト' do
        invitation_params = { invitation_code: owner.group.invitation_code, inviter_email: users(:member2_of_group1).email }
        assert_difference 'owner.group.users.count', 0 do
          assert_difference 'UserGroup.count', 0 do
            post users_path, params: user_params.merge(invitation_params)
          end
        end
        assert_redirected_to welcome_path(user: user_params)
      end

      it '招待コードが間違っている場合は、ユーザーは作成されず、welcomeページにリダイレクト' do
        invitation_params = { invitation_code: 'invalid_code', inviter_email: owner.email }
        assert_difference 'owner.group.users.count', 0 do
          assert_difference 'UserGroup.count', 0 do
            post users_path, params: user_params.merge(invitation_params)
          end
        end
        assert_redirected_to welcome_path(user: user_params)
      end
    end

    describe '招待されていない場合' do
      it 'ユーザーとグループを作成し、ログインしてタスク一覧画面にリダイレクト' do
        assert_difference 'User.count', 1 do
          assert_difference 'UserGroup.count', 1 do
            post users_path, params: user_params
          end
        end
        assert_redirected_to repetitive_tasks_path
      end
    end
  end

  describe 'destroy' do
    describe 'ログイン時' do
      describe 'ログインユーザーが自身を削除する場合' do
        it '削除し、ログアウトしてトップページにリダイレクト' do
          create_user_and_log_in
          current_user = User.last
          assert_difference 'User.count', -1 do
            assert_difference 'UserGroup.count', 0 do
              delete user_path(current_user)
            end
          end
          assert_redirected_to root_path
        end
      end

      describe 'オーナーとして他人を削除する場合' do
        before do
          create_user_and_log_in
          @current_user = User.last
          @member = users(:member1_of_group1)
        end

        it '対象がグループのメンバーなら削除し、ユーザーグループ画面にリダイレクト' do
          @member.update!(group_id: @current_user.group.id)
          assert_difference 'User.count', -1 do
            assert_difference 'UserGroup.count', 0 do
              delete user_path(@member)
            end
          end
          assert_redirected_to user_groups_path
        end

        it '対象がグループのメンバーでないなら何もしない' do
          assert_difference 'User.count', 0 do
            assert_difference 'UserGroup.count', 0 do
              delete user_path(@member)
            end
          end
          assert_response :success
        end
      end
    end

    describe 'ログアウト時' do
      it 'トップページにリダイレクト' do
        delete user_path(users(:owner1))
        assert_redirected_to root_url
      end
    end
  end
end
