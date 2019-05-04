require 'rails_helper'

RSpec.describe 'User API', type: :request do
  describe 'GET /v1/users' do
    let!(:user) { create :user }
    let!(:user2) { create :user }
    let(:path) { '/api/v1/users' }

    subject do
      get path
      response
    end

    describe 'Response successful' do
      context 'with no parameter' do
        it { is_expected.to have_http_status(:ok) }
        it { expect(data.count).to eq(2) }
        it do
          expect(data[0]).to include_json(
            id: user.id,
            name: user.name
          )
        end
      end
    end
  end
end
