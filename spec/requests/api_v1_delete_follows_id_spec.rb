require 'rails_helper'

RSpec.describe 'Follows API', type: :request do
  describe 'DELETE /v1/follows/:id' do
    let(:current_user) { create :user }
    let(:user) { create :user }
    let!(:follow) { current_user.follows.create(to_user: user) }
    let(:follow_id) { follow.id.to_s }
    let(:path) { '/api/v1/follows/' + follow_id }

    include_context :subject_delete

    describe 'Response successful' do
      context 'with correct :follow_id' do
        let(:headers) { authenticate_with(current_user.auth) }
        it { is_expected.to have_http_status(:ok) }
        it do
          expect(data).to include_json(
            message: 'Unfollowed successful',
            id: follow.id,
            to_user: {
              id: follow.to_user.id,
              name: follow.to_user.name
            }
          )
        end
      end
    end

    describe 'Response error' do
      include_examples :unauthorized

      context 'with not existing :follow_id' do
        let(:follow_id) { 100.to_s }
        let(:headers) { authenticate_with(current_user.auth) }
        it { is_expected.to have_http_status(:not_found) }
        it do
          expect(error).to include_json(
            message: "Couldn't find Follow with 'id'=#{follow_id}",
            status: 404
          )
        end
      end

      context 'with not allowed doing this operation' do
        let(:user_2) { create :user }
        let!(:follow) { user_2.follows.create(to_user: user) }
        let(:follow_id) { follow.id.to_s }
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
