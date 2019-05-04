require 'rails_helper'

RSpec.describe 'User API', type: :request do
  describe 'GET /v1/users/:id' do
    let(:current_user) { create :user }
    let(:user) { create :user }
    let(:user_id) { user.id.to_s }
    let(:path) { '/api/v1/users/' + user_id }

    include_context :subject_get

    describe 'Response successful' do
      context 'with correct :user_id' do
        let(:headers) { authenticate_with(current_user.auth) }
        it { is_expected.to have_http_status(:ok) }
        it do
          expect(data).to include_json(
            id: user.id,
            name: user.name,
            created_at: user.created_at.as_json,
            updated_at: user.updated_at.as_json
          )
        end
      end
    end

    describe 'Response error' do
      include_examples :unauthorized

      context 'with not existing :user_id' do
        let(:headers) { authenticate_with(current_user.auth) }
        let(:user_id) { 999.to_s }
        it { is_expected.to have_http_status(:not_found) }
        it do
          expect(error).to include_json(
            message: "Couldn't find User with 'id'=999",
            status: 404
          )
        end
      end
    end
  end
end
