require 'rails_helper'

RSpec.describe 'Sleeps clockout API', type: :request do
  describe 'GET /v1/sleeps/clockout' do
    let!(:current_user) { create :user }
    let(:path) { '/api/v1/sleeps/clockout' }

    include_context :subject_get

    describe 'Response successful' do
      context 'with correct authorization' do
        let!(:sleep) do
          time = Time.current
          current_user.sleeps.create(date: time.to_date, clockin_at: 5.hours.since(time))
        end
        let(:headers) { authenticate_with(current_user.auth) }
        it { is_expected.to have_http_status(:ok) }
        it do
          expect(data).to include_json(
            date: sleep.reload.date.as_json,
            clockin_at: sleep.reload.clockin_at.as_json,
            clockout_at: sleep.reload.clockout_at.as_json
          )
        end
      end
    end

    describe 'Response error' do
      include_examples :unauthorized

      context 'already clocked out at' do
        let!(:sleep) do
          time = Time.current
          current_user.sleeps.create(date: time.to_date, clockin_at: 5.hours.since(time), clockout_at: time)
        end
        let(:headers) { authenticate_with(current_user.auth) }
        it { is_expected.to have_http_status(:unprocessable_entity) }
        it do
          expect(error).to include_json(
            message: "Already clocked out at: #{sleep.reload.clockout_at}",
            status: 422
          )
        end
      end
    end
  end
end
