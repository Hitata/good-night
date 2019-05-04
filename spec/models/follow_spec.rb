require 'rails_helper'

RSpec.describe Follow, type: :model do
  let(:user1) { build(:user) }
  let(:user2) { build(:user) }

  subject(:follow) { Follow.new(from_user: user1, to_user: user2) }

  it 'is valid with to_user and from_user' do
    is_expected.to be_valid
  end

  context 'has association' do
    it 'of belongs_to to_user' do
      is_expected.to belong_to(:to_user)
    end
    it 'of belongs_to from_user' do
      is_expected.to belong_to(:from_user)
    end
  end

  context 'has table indexes' do
    it 'of [from_user_id, to_user_id]' do
      is_expected.to have_db_index(%i[from_user_id to_user_id]).unique(true)
    end
  end
end
