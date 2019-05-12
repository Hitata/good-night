require 'rails_helper'

RSpec.describe 'Authenticate API', type: :request do
  describe 'GET /v1/auth' do
    let!(:login_user) { create :user }
    let(:path) { '/api/v1/auth' }

    include_context :subject_get

    describe 'Response successful' do
      context 'with existing user name' do
        let(:params) do
          {name: login_user.name}
        end
        it { is_expected.to have_http_status(:ok) }
        it do
          expect(data).to include_json(
            id: login_user.id,
            name: login_user.name,
            auth: login_user.auth
          )
        end
      end
    end

    describe 'Response error' do
      context 'with no paramters: name' do
        it { is_expected.to have_http_status(:bad_request) }
        it do
          expect(error).to include_json(
            message: 'param is missing or the value is empty: name',
            status: 400
          )
        end
      end

      context 'with not existing user name' do
        let(:params) do
          {name: 'trung-invalid'}
        end
        it { is_expected.to have_http_status(:unauthorized) }
        it do
          expect(error).to include_json(
            message: "User with name: '#{params[:name]}' doesn't exist",
            status: 401
          )
        end
      end
    end
  end
end
