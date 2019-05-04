require 'rails_helper'

RSpec.describe 'User API', type: :request do
  describe 'GET /v1/users/:id' do
    let(:user) { create :user }
    let(:path) { '/api/v1/users' }

    subject do
      get path + '/' + user_id.to_s
      response
    end

    describe 'Response successful' do
      context 'with correct :user_id' do
        let(:user_id) { user.id }
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
      context 'with not existing :user_id' do
        let(:user_id) { 999 }
        it { is_expected.to have_http_status(:not_found) }
        it do
          expect(error).to include_json(
            message: "Couldn't find User with 'id'=999",
            status: 404
          )
        end
      end

      # TODO: authentication error
    end
  end
end
