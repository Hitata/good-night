require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  it 'is valid with name and auth' do
    is_expected.to be_valid
  end

  context 'has association' do
    it 'of has_many follows' do
      is_expected.to have_many(:follows)
    end
    it 'of has_many followings' do
      is_expected.to have_many(:followings)
    end
  end

  context 'has validations' do
    it 'of presence: name' do
      is_expected.to validate_presence_of(:name)
    end
    it 'of presence: auth' do
      is_expected.to validate_presence_of(:auth)
    end
    it 'of uniqueness: name' do
      is_expected.to validate_uniqueness_of(:name)
    end
    it 'of uniqueness: auth' do
      is_expected.to validate_uniqueness_of(:auth)
    end
  end

  context 'has table indexes' do
    it 'of auth' do
      is_expected.to have_db_index(:auth)
    end
  end
end
