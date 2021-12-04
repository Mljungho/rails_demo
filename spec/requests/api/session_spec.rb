RSpec.describe 'POST /api/auth/sign_in', type: :request do
  let(:user) { create(:user) }
  let(:expected_response) do
    {
      'data' => {
        'id' => user.id, 'uid' => user.email, 'email' => user.email,
        'provider' => 'email', 'allow_password_change' => false
      }
    }
  end
  describe 'with valid credentials' do
    before do
      post '/api/auth/sign_in',
           params: {
             email: user.email,
             password: user.password
           }
    end

    it 'return 200 response status' do
      expect(respopnse).to have_http_status 200
    end

    it 'returns the expeted response' do
      expect(response_json).to eq expected_response
    end
  end

  describe 'with invalid passowrd' do
    before do
      post '/api/auth/sign_in',
           params: {
             email: user.email,
             password: 'wrong_password'
           }
    end

    it 'returns 401 response status' do
      expect(response).to have_http_status 401
    end

    it 'returns error message' do
      expect(response_json['errors']).to eq ['Invalid login credentials. Please try again.']
    end
  end

  describe 'with valid email' do
    before do
      post '/api/auth/sign_in',
           params: {
             email: 'wrong@email.com',
             password: user.password
           }
    end

    it 'returns 401 response status' do
      expect(response).to have_http_status 401
    end

    it 'return error message' do
      expect(response_json['errors']).to eq ['Invalid login credentials. Please try again.']
    end
  end
end
