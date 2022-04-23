require "test_helper"

class UserTest < ActiveSupport::TestCase
  let(:user) { users(:one) }

  describe 'responses' do
    it 'responses correctly' do
      expect(user).must_respond_to(:name)
      expect(user).must_respond_to(:email)
      expect(user).must_respond_to(:group)
      expect(user).must_respond_to(:group_id)
    end
  end

  describe 'validations' do
    it 'バリデーション通る' do
      expect(user.valid?).must_equal true
    end

    it 'nameが空ならバリデーションエラー' do
      user.name = ''
      expect(user.valid?).must_equal false
      expect(user.errors[:name]).must_include "を入力してください"
    end

    it 'emailが空ならバリデーションエラー' do
      user.email = ''
      expect(user.valid?).must_equal false
      expect(user.errors[:email]).must_include "を入力してください"
    end
  end

  describe 'User.create_with_group!' do
    it 'ユーザーとグループが同時に作成される' do
      user_params = { name: 'test', email: 'example@example.com' }
      assert_difference 'User.count', 1 do
        assert_difference 'UserGroup.count', 1 do
          User.create_with_group!(user_params)
        end
      end
      last_user = User.last
      expect(last_user.name).must_equal user_params[:name]
      expect(last_user.email).must_equal user_params[:email]
      expect(UserGroup.last.owner).must_equal User.last
    end
  end

  describe 'User#owner?' do
    it 'グループのオーナーならtrue' do
      owner_user = users(:owner)
      expect(owner_user.owner?).must_equal true
    end

    it 'グループのオーナーでなければfalse' do
      expect(user.owner?).must_equal false
    end
  end
end
