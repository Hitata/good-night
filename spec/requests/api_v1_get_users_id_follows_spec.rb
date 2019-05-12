require 'rails_helper'

RSpec.describe 'Follows API', type: :request do
  describe 'GET /v1/users/:id/follows' do
    let(:current_user) { create :user }
    let(:user) { create :user }
    let!(:follow) { current_user.follows.create(to_user: user) }
    let(:path) { '/api/v1/users/' + current_user.id.to_s + '/follows' }

    include_context :subject_get

    describe 'Response successful' do
      context 'with correct :user_id' do
        let(:headers) { authenticate_with(current_user.auth) }
        it { is_expected.to have_http_status(:ok) }
        it { expect(data.count).to eq(1) }
        it do
          expect(data[0]).to include_json(
            id: follow.id,
            to_user: {
              id: user.id,
              name: user.name
            }
          )
        end
      end
    end

    describe 'Response error' do
      include_examples :unauthorized
    end
  end
end
