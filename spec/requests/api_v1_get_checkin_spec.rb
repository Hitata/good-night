require 'rails_helper'

RSpec.describe 'Sleeps clockin API', type: :request do
  describe 'POST /v1/sleeps/clockin' do
    let!(:current_user) { create :user }
    let(:sleep) { current_user.sleeps.first }
    let(:path) { '/api/v1/sleeps/clockin' }

    include_context :subject_post

    describe 'Response successful' do
      context 'with correct authorization' do
        let(:headers) { authenticate_with(current_user.auth) }
        it { is_expected.to have_http_status(:ok) }
        it do
          expect(data).to include_json(
            id: sleep.reload.id,
            date: sleep.reload.date.as_json,
            clockin_at: sleep.reload.clockin_at.as_json,
            clockout_at: nil
          )
        end
      end
    end

    describe 'Response error' do
      include_examples :unauthorized

      context 'already clocked in at' do
        let!(:sleep) do
          time = Time.current
          current_user.sleeps.create(date: time.to_date, clockin_at: time)
        end
        let(:headers) { authenticate_with(current_user.auth) }
        it { is_expected.to have_http_status(:unprocessable_entity) }
        it do
          expect(error).to include_json(
            message: "Already clocked in at: #{sleep.reload.clockin_at}",
            status: 422
          )
        end
      end
    end
  end
end
