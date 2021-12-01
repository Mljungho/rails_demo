describe 'POST /api/articles' do
  subject { response }

  describe 'successfully' do
    before do
      post '/api/articles',
           params: {
             article: {
               title: 'My awesome article',
               body: 'My text bla bla'
             }
           }
    end

    it 'is expected to return status 201' do
      expect(subject.status).to eq 201
    end

    it { is_expected.to have_http_status :created }

    it 'is expected to return the new object with a title' do
      expect(response_json['article']['title']).to eq 'My awesome article'
    end

    it 'is expected to return the new object with a title' do
      expect(response_json['article']['body']).to eq 'My text bla bla'
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
