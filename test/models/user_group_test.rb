require "test_helper"

class UserGroupTest < ActiveSupport::TestCase
  let(:user_group) { user_groups(:one) }

  describe 'responses' do
    it 'responses correctly' do
      expect(user_group).must_respond_to(:users)
      expect(user_group).must_respond_to(:owner)
      expect(user_group).must_respond_to(:repetitive_tasks)
      expect(user_group).must_respond_to(:invitation_code)
    end
  end

  describe 'validations' do
    it 'バリデーション通る' do
      expect(user_group.valid?).must_equal true
    end

    it 'owner_idがユニークでなければバリデーションエラー' do
      user_group.owner_id = users(:owner2).id
      expect(user_group.valid?).must_equal false
      expect(user_group.errors[:owner_id]).must_include "はすでに存在します"
    end
  end

  describe 'instance methods' do
    describe '#valid_invitation_code?' do
      it 'invitation_codeが一致すればtrue' do
        expect(user_group.valid_invitation_code?(user_group.invitation_code)).must_equal true
      end

      it 'invitation_codeが一致しなければfalse' do
        expect(user_group.valid_invitation_code?('invalid_code')).must_equal false
      end
    end
  end
end
