# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  describe 'responses' do
    let(:user) { users(:member1_of_group1) }

    it 'responses correctly' do
      expect(user).must_respond_to(:name)
      expect(user).must_respond_to(:email)
      expect(user).must_respond_to(:remember_token)
      expect(user).must_respond_to(:group)
      expect(user).must_respond_to(:group_id)
    end
  end

  describe 'validations' do
    let(:user) { users(:member1_of_group1) }

    it 'バリデーション通る' do
      expect(user.valid?).must_equal true
    end

    it 'nameが空ならバリデーションエラー' do
      user.name = ''
      expect(user.valid?).must_equal false
      expect(user.errors[:name]).must_include 'を入力してください'
    end

    it 'emailが空ならバリデーションエラー' do
      user.email = ''
      expect(user.valid?).must_equal false
      expect(user.errors[:email]).must_include 'を入力してください'
    end
  end

  describe 'class methods' do
    let(:user_params) { { name: 'test', email: 'example@example.com' } }

    describe 'User.create_by_invitation' do
      let(:owner_user) { users(:owner1) }
      let(:invitation_params) { { invitation_code: owner_user.group.invitation_code, inviter_email: owner_user.email } }

      it 'オーナーのemailと正しい招待コードが入力されれば、ユーザーが作成され、招待されたグループに入る' do
        assert_difference 'User.count', 1 do
          assert_difference 'UserGroup.count', 0 do
            new_user = User.create_by_invitation(user_params, invitation_params)
            expect(new_user).must_be_instance_of User
            expect(new_user.group).must_equal owner_user.group
          end
        end
      end

      it 'emailでユーザーが見つからない場合は、ユーザーは作成されず、falseが返る' do
        invalid_invitation_params = { invitation_code: owner_user.group.invitation_code, inviter_email: 'invalid@invalid.com' }
        assert_difference 'User.count', 0 do
          assert_difference 'UserGroup.count', 0 do
            new_user = User.create_by_invitation(user_params, invalid_invitation_params)
            expect(new_user).must_equal false
          end
        end
      end

      it 'emailがオーナーのemailでない場合は、ユーザーは作成されず、falseが返る' do
        invalid_invitation_params = { invitation_code: owner_user.group.invitation_code, inviter_email: users(:member2_of_group1).email }
        assert_difference 'User.count', 0 do
          assert_difference 'UserGroup.count', 0 do
            new_user = User.create_by_invitation(user_params, invalid_invitation_params)
            expect(new_user).must_equal false
          end
        end
      end

      it '招待コードが間違っている場合は、ユーザーは作成されず、falseが返る' do
        invalid_invitation_params = { invitation_code: 'invalid_code', inviter_email: owner_user.email }
        assert_difference 'User.count', 0 do
          assert_difference 'UserGroup.count', 0 do
            new_user = User.create_by_invitation(user_params, invalid_invitation_params)
            expect(new_user).must_equal false
          end
        end
      end
    end

    describe 'User.create_with_group_as_owner!' do
      it 'ユーザーとグループが同時に作成される' do
        assert_difference 'User.count', 1 do
          assert_difference 'UserGroup.count', 1 do
            new_user = User.create_with_group_as_owner!(user_params)
            expect(new_user.name).must_equal user_params[:name]
            expect(new_user.email).must_equal user_params[:email]
            expect(UserGroup.last.owner).must_equal new_user
          end
        end
      end
    end
  end

  describe 'instance methods' do
    let(:user) { users(:member1_of_group1) }

    describe 'User#owner?' do
      it 'グループのオーナーならtrue' do
        owner_user = users(:owner1)
        expect(owner_user.owner?).must_equal true
      end

      it 'グループのオーナーでなければfalse' do
        expect(user.owner?).must_equal false
      end
    end

    describe 'User#able_to_destroy?' do
      let(:owner_user) { users(:owner1) }
      it 'グループのオーナーで、削除対象が自分のグループのメンバーで自分自身でなければtrue' do
        expect(owner_user.able_to_destroy?(user)).must_equal true
      end

      it '削除対象が自分自身であればfalse' do
        expect(owner_user.able_to_destroy?(owner_user)).must_equal false
      end

      it 'グループのオーナーでなければfalse' do
        expect(user.able_to_destroy?(users(:member2_of_group1))).must_equal false
      end

      it '削除対象が自分のグループのメンバーでなければfalse' do
        expect(owner_user.able_to_destroy?(users(:member1_of_group2))).must_equal false
      end
    end

    describe 'User#member_of?' do
      it 'グループのメンバーならtrue' do
        expect(user.member_of?(user.group)).must_equal true
      end

      it 'グループのオーナーならtrue' do
        owner_user = users(:owner1)
        expect(owner_user.member_of?(owner_user.group)).must_equal true
      end

      it 'グループのメンバーでなければfalse' do
        another_group = user_groups(:two)
        expect(user.member_of?(another_group)).must_equal false
      end
    end

    describe 'User#authenticated?' do
      it 'remember_tokenと一致すればtrue' do
        expect(user.authenticated?(user.remember_token)).must_equal true
      end

      it 'remember_tokenと一致しなければfalse' do
        expect(user.authenticated?('invalid_token')).must_equal false
      end
    end
  end
end
