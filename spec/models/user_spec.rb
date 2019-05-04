require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  it 'is valid with name and auth' do
    expect(user).to be_valid
  end

  context 'has validations' do
    it 'of uniqueness: name' do
      expect(user).to validate_uniqueness_of(:name)
    end
    it 'of uniqueness: auth' do
      expect(user).to validate_uniqueness_of(:auth)
    end
  end

  context 'has table indexes' do
    it 'of auth' do
      expect(user).to have_db_index(:auth)
    end
  end
end
