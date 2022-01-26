RSpec.describe ' GET /api/articles/:id' do
  describe 'successfully' do
    let!(:article) do
      create(:article, title: 'Title', content: 'changed to longer text for fun sake. This is a preset.')
    end

    before do
      get "/api/articles/#{article.id}"
    end

    it 'is expected to return a 200 status' do
      expect(response).to have_http_status 200
    end

    it 'is expected to return the request articles title' do
      expect(response_json['article']['title']).to eq 'Title'
    end

    it 'is expected to return the requested articles content' do
      expect(response_json['article']['content']).to eq 'changed to longer text for fun sake. This is a preset.'
    end
  end

  describe 'unccsessfull with invalid id' do
    before do
      get 'api/articles/abc'
    end

    it 'is excpected to return a 404 status' do
      expect(response).to have_http_status 200
    end

    it 'is expected to return an error message' do
      expect(response_json['message']).to eq 'Unfortunatley we can not find the article you are looking for'
    end
  end
end
