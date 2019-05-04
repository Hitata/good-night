require 'rails_helper'

RSpec.describe 'User API', type: :request do
  describe 'GET /v1/users' do
    let!(:current_user) { create :user }
    let!(:users) { create_list :user, 5 }
    let(:path) { '/api/v1/users' }

    include_context :subject_get

    describe 'Response successful' do
      context 'with correct authorization & no parameters' do
        let(:headers) { authenticate_with(current_user.auth) }
        it { is_expected.to have_http_status(:ok) }
        it { expect(data.count).to eq(5) }
        it do
          expect(data[0]).to include_json(
            id: users.last.id,
            name: users.last.name
          )
        end
      end
    end

    describe 'Response error' do
      include_examples :unauthorized
    end
  end
end
