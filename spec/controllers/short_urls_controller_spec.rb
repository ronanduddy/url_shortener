require 'rails_helper'

RSpec.describe ShortUrlsController do
  pending "test controller #{__FILE__}"
  xdescribe "GET index" do
    it "assigns @short_urls" do
      short_urls = [FactoryBot.create(:short_url)]
      get :index

      expect(assigns(:short_urls)).to eq(short_urls)
    end
  end
end
