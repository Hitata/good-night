require 'rails_helper'

RSpec.describe 'User API', type: :request do
  describe 'GET /v1/users/:id/last_week_order_sleep_time' do
    let(:current_user) { create :user }
    let(:user_id) { current_user.id.to_s }
    let!(:sleeps) do
      today = Date.current
      (1.week.ago(today)..today).each do |date|
        current_user.sleeps.create(
          date: date,
          clockin_at: date.end_of_day - rand(0..4).hours,
          clockout_at: date.end_of_day + rand(0..8).hours
        )
      end
    end

    let(:path) { '/api/v1/users/' + user_id + '/last_week_order_sleep_time' }

    include_context :subject_get

    describe 'Response successful' do
      context 'with correct order of max and min' do
        let(:headers) { authenticate_with(current_user.auth) }
        let(:sleeps_order_sleep_time) { current_user.sleeps.from_date_order_by_sleep_time(1.week.ago) }
        let(:first_in_desc_sleep) { sleeps_order_sleep_time[0] }
        let(:last_in_desc_sleep) { sleeps_order_sleep_time[-1] }
        it { is_expected.to have_http_status(:ok) }
        it 'which has max sleep_time as first record' do
          expect(data.first).to include_json(
            id: first_in_desc_sleep.id,
            date: first_in_desc_sleep.date.as_json,
            clockin_at: first_in_desc_sleep.clockin_at.as_json,
            clockout_at: first_in_desc_sleep.clockout_at.as_json,
            sleep_time: first_in_desc_sleep.sleep_time
          )
        end

        it 'which has min sleep_time as last record' do
          expect(data.last).to include_json(
            id: last_in_desc_sleep.id,
            date: last_in_desc_sleep.date.as_json,
            clockin_at: last_in_desc_sleep.clockin_at.as_json,
            clockout_at: last_in_desc_sleep.clockout_at.as_json,
            sleep_time: last_in_desc_sleep.sleep_time
          )
        end
      end
    end

    describe 'Response error' do
      include_examples :unauthorized
    end
  end
end
