require 'rails_helper'

RSpec.describe 'Follows API', type: :request do
  describe 'GET /v1/users/:id/follows' do
    let(:current_user) { create :user }
    let(:user) { create :user }
    let(:follow) { current_user.follows.first }
    let(:path) { '/api/v1/users/' + user.id.to_s + '/follows' }

    include_context :subject_post

    describe 'Response successful' do
      context 'with correct :user_id' do
        let(:headers) { authenticate_with(current_user.auth) }
        it { is_expected.to have_http_status(:ok) }
        it do
          expect(data).to include_json(
            id: follow.reload.id,
            to_user: {
              id: follow.reload.to_user.id,
              name: follow.reload.to_user.name
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
