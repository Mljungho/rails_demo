RSpec.describe ' GET /api/articles/:id' do
    describe 'successfully' do
        let!(:article) { create(:article, title: 'This is the latest news', body: 'And this is some kind of mindblowing content') }

        before do
            get "/api/articles/#{article.id}"
        end

        it 'is expected to return a 200 status' do
            expect(response).to have_http_status 200
        end

        it 'is expected to return the request articles title' do
            expect(response_json['article']['title']).to eq 'This is the latest news'
        end

        it 'is expected to return the requested articles body' do
            expect(response_json['article']['body']).to eq 'And this is some kind of mindblowing content'
        end
    end
end