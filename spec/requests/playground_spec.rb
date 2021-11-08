require 'rails_helper'

describe 'Playground API', type: :request do
  describe 'GET /playground' do
    before do
      FactoryBot.create(:playground, username: 'Khagan', roomName: 'room one', password: 'password', moves: '', people: '["khagan","hadassah"]', next:'khagan', status:'{"X":"play","O":"play"}', scores: '[0,0]')
      FactoryBot.create(:playground, username: 'hadassah', roomName: 'room two', password: 'password', moves: '', people: '["hadassah", "khagan"]', next:'khagan', status:'{"X":"play","O":"play"}', scores: '[0,0]')
    end
    it 'returns all playground' do
      get '/api/v1/playground'

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end 

  describe 'GET /playground/:id' do
    let!(:playground) { FactoryBot.create(:playground, username: 'Khagan', roomName: 'room one', password: 'password', moves: '', people: '["khagan","hadassah"]', next:'khagan', status:'{"X":"play","O":"play"}', scores: '[0,0]') }

    it 'returns playground by id' do
      get "/api/v1/playground/#{playground.id}"

      expect(response).to have_http_status(:success)
    end
  end
  
  describe 'POST /playground' do
    it 'creates a new playground' do
      expect {
        post '/api/v1/playground', params: {playground: {username: 'Khagan', roomName: 'room one', password: 'password', moves: '', people: '["khagan","hadassah"]', next:'khagan', status:'{"X":"play","O":"play"}', scores: '[0,0]'}}
      }.to change {Playground.count}.from(0).to(1)

      expect(response).to have_http_status(:created)
    end
  end

  describe 'PATCH /playground/:id' do
    let!(:playground) { FactoryBot.create(:playground, username: 'Khagan', roomName: 'room one', password: 'password', moves: '', people: '["khagan","hadassah"]', next:'khagan', status:'{"X":"play","O":"play"}', scores: '[0,0]') }

    it 'updates playground by id' do
      patch "/api/v1/playground/#{playground.id}", params: {playground: { scores: '[1,1]', next:'hadassah' }}

      expect(response).to have_http_status(:success)
    end
  end
end