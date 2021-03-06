describe 'POST /api/articles' do
  subject { response }
  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }

  describe 'with valid params' do
    describe 'as an anonymous user' do
      before do
        post '/api/articles',
             params: {
               article: {
                 title: 'My awesome article',
                 content: 'My text bla bla'
               }
             }, headers: nil
      end

      it { is_expected.to have_http_status :unauthorized }
    end

    describe 'as an authenticated user' do
      before do
        post '/api/articles',
             params: {
               article: {
                 title: 'My awesome article',
                 content: 'My text bla bla'
               }
             }, headers: credentials
      end

      it 'is expected to return status 201' do
        expect(subject.status).to eq 201
      end

      it { is_expected.to have_http_status :created }

      it 'is expected to return the new object with a title' do
        expect(response_json['article']['title']).to eq 'My awesome article'
      end

      it 'is expected to return the new object with a article content' do
        expect(response_json['article']['content']).to eq 'My text bla bla'
      end
    end

    describe 'unsuccessfully' do
      describe 'due to missing params' do
        before do
          post '/api/articles', params: {}
        end

        it { is_expected.to have_http_status 422 }

        it 'is expected to respond with an error message' do
          expect(response_json['message']).to eq 'Missing params'
        end

        describe do
          it 'is expected to respond with an error message' do
            expect(response_json[])
          end
        end
      end
    end
  end
end
