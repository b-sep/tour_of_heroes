require 'rails_helper'

RSpec.describe "/api/heroes", type: :request do
  let(:name){ 'thor' }
  let(:token){ '0123456789' }

  let(:valid_attributes) {
    { name: name, token: token }
  }

  let(:invalid_attributes) {
    { name: nil, token: nil }
  }

  let(:valid_headers) {
    { authorization: token }
  }

  describe "GET /index" do
    context 'with headers' do
      it "renders a successful response" do
        Hero.create! valid_attributes
        get api_heroes_url, headers: valid_headers, as: :json
        expect(response).to be_successful
      end
    end

    context 'without headers' do
      it 'renders a JSON response with an unauthorized status' do
        Hero.create! valid_attributes
        get api_heroes_url, as: :json
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      hero = Hero.create! valid_attributes
      get api_hero_url(hero), headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Hero" do
        expect {
          post api_heroes_url,
               params: { hero: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Hero, :count).by(1)
      end

      it "renders a JSON response with the new hero" do
        post api_heroes_url,
             params: { hero: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Hero" do
        expect {
          post api_heroes_url,
               params: { hero: invalid_attributes }, as: :json
        }.to change(Hero, :count).by(0)
      end

      it "renders a JSON response with errors for the new hero" do
        post api_heroes_url,
             params: { hero: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { name: 'lanterna verde' }
      }

      it "updates the requested hero" do
        hero = Hero.create! valid_attributes
        patch api_hero_url(hero),
              params: { hero: new_attributes }, headers: valid_headers, as: :json
        hero.reload
        expect(hero.name).to eq 'lanterna verde'
      end

      it "renders a JSON response with the hero" do
        hero = Hero.create! valid_attributes
        patch api_hero_url(hero),
              params: { hero: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the hero" do
        hero = Hero.create! valid_attributes
        patch api_hero_url(hero),
              params: { hero: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested hero" do
      hero = Hero.create! valid_attributes
      expect {
        delete api_hero_url(hero), headers: valid_headers, as: :json
      }.to change(Hero, :count).by(-1)
    end
  end
end
