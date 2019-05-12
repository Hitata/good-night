module ShareExampleHelper
  shared_context :subject_get do
    let(:params) {}
    subject do
      get path, params: params, headers: headers
      response
    end
  end

  shared_context :subject_post do
    let(:params) {}
    subject do
      post path, params: params, headers: headers
      response
    end
  end

  shared_context :subject_delete do
    subject do
      delete path, headers: headers
      response
    end
  end

  shared_examples :unauthorized do
    context 'with no headers' do
      it { is_expected.to have_http_status(:unauthorized) }
      it do
        expect(error).to include_json(
          message: 'Authorization token incorrect',
          status: 401
        )
      end
    end
    context 'with wrong authorization' do
      let(:headers) { authenticate_with('123456789=') }
      it { is_expected.to have_http_status(:unauthorized) }
      it do
        expect(error).to include_json(
          message: 'Authorization token incorrect',
          status: 401
        )
      end
    end
  end
end
