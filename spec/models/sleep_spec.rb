require 'rails_helper'

RSpec.describe Sleep, type: :model do
  let(:user) { build(:user) }
  subject(:sleep) { Sleep.new(user: user, date: Date.current) }

  it 'is valid with user and date' do
    is_expected.to be_valid
  end

  context 'has association' do
    it 'of belongs_to user' do
      is_expected.to belong_to(:user)
    end
  end

  context 'has validations' do
    it 'of presence: date' do
      is_expected.to validate_presence_of(:date)
    end
  end

  context 'has table indexes' do
    it 'of [:user_id, :date]' do
      is_expected.to have_db_index(%i[user_id date]).unique(true)
    end
  end
end
