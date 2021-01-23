require 'rails_helper'

RSpec.describe ShortUrl, type: :model do
  let(:short_url) { FactoryBot.build(:short_url) }

  context 'with no user association' do
    before { short_url.user = nil }

    it 'is invalid' do
      expect(short_url).to be_invalid
      expect(short_url.errors.messages).to include :user
    end
  end

  context 'with URL attribute' do
    it 'is invalid when nil' do
      short_url.url = nil
      expect(short_url).to be_invalid
    end

    it 'is invalid when length < 16' do
      short_url.url = 'S]Ken&xyL2Fwc]#'
      expect(short_url).to be_invalid
    end

    it 'is invalid when length > 64' do
      short_url.url = '6spEhN5U9BmYNLKVvFS8EwDWxsUBNlNSUTHVInoBFwaDp8Gzc9tnTh5FHurB3wZdS'
      expect(short_url).to be_invalid
    end

    it 'is valid when length >= 16 and <= 64' do
      short_url.url = 'http://www.example.com/'
      expect(short_url).to be_valid
    end

    pending "is valid URL #{__FILE__}"
    pending "is unique URL #{__FILE__}"
  end

  context 'with slug attribute' do
    it 'generates a slug when nil' do
      short_url.slug = nil
      expect(short_url).to be_valid
    end

    it 'is invalid when length < 8' do
      short_url.slug = '5'
      expect(short_url).to be_invalid
    end

    it 'is invalid when length > 8' do
      short_url.slug = '4564r454654654'
      expect(short_url).to be_invalid
    end

    it 'is valid when length is 8' do
      short_url.slug = 'abcdefgh'
      expect(short_url).to be_valid
    end

    it 'must be unique' do
      short_url.slug = '12345678'
      expect(short_url.save).to be true

      new_short_url = FactoryBot.build(:short_url, slug: short_url.slug)
      expect(new_short_url).to be_invalid      
    end
  end

  context 'with views attribute' do
    it 'has a default value of 0' do
      expect(short_url.views).to eq 0
    end

    it 'must be >= 0' do
      expect(short_url).to be_valid
      short_url.views = 1
      expect(short_url).to be_valid
    end

    it 'cannot be < 0' do
      short_url.views = -1
      expect(short_url).to be_invalid
    end

    it 'cannot be set to nil' do
      short_url.views = nil
      expect(short_url).to be_invalid
    end

    it 'increments by 1 if touched' do
      short_url.save

      short_url.touch
      expect(short_url.views).to eq 1

      short_url.touch
      expect(short_url.views).to eq 2
    end
  end
end
