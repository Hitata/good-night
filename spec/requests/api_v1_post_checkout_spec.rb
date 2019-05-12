require 'rails_helper'

RSpec.describe 'Sleeps clockout API', type: :request do
  describe 'POST /v1/sleeps/:id/clockout' do
    let!(:current_user) { create :user }
    let!(:sleep) do
      time = Time.current
      current_user.sleeps.create(date: time.to_date, clockin_at: 5.hours.since(time))
    end
    let(:sleep_id) { sleep.id.to_s }
    let(:path) { '/api/v1/sleeps/' + sleep_id + '/clockout' }

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
        let(:sleep_id) { sleep.id.to_s }
        let(:headers) { authenticate_with(current_user.auth) }
        it { is_expected.to have_http_status(:unprocessable_entity) }
        it do
          expect(error).to include_json(
            message: "Already clocked out at: #{sleep.reload.clockout_at}",
            status: 422
          )
        end
      end

      context 'with not existing :sleep_id' do
        let(:sleep_id) { 100.to_s }
        let(:headers) { authenticate_with(current_user.auth) }
        it { is_expected.to have_http_status(:not_found) }
        it do
          expect(error).to include_json(
            message: "Couldn't find Sleep with 'id'=#{sleep_id}",
            status: 404
          )
        end
      end

      context 'with not allowed doing this operation' do
        let(:user_2) { create :user }
        let!(:sleep) do
          time = Time.current
          user_2.sleeps.create(date: time.to_date, clockin_at: 5.hours.since(time), clockout_at: time)
        end
        let(:sleep_id) { sleep.id.to_s }
        let(:headers) { authenticate_with(current_user.auth) }
        it { is_expected.to have_http_status(:unprocessable_entity) }
        it do
          expect(error).to include_json(
            message: 'Not allowed doing this operation',
            status: 422
          )
        end
      end
    end
  end
end
