require 'rails_helper'

RSpec.describe ShortUrl, type: :model do
  let(:short_url) { FactoryBot.build(:short_url) }

  context 'with no User association' do
    before { short_url.user = nil }

    it 'is invalid' do
      expect(short_url).to be_invalid
      expect(short_url.errors.messages).to include :user
    end
  end

  context 'with default ordering' do
    before { FactoryBot.create_list(:short_url, 5) }

    it 'returns in descending order' do
      id = ShortUrl.first.id    
      ShortUrl.all.each do |short_url|
        expect(short_url.id).to eq id
        id -= 1
      end
    end
  end

  context 'with URL attribute' do
    it 'is invalid when nil' do
      short_url.url = nil
      expect(short_url).to be_invalid
    end

    it 'is invalid when length < 16' do
      short_url.url = 'http://www.a.cm'
      expect(short_url).to be_invalid
    end

    it 'is invalid when length > 128' do
      short_url.url = 'http://www.exampleexampleexampleexampleexampleexample' \
                      'exampleexampleexampleexampleexampleexampleexample' \
                      'exampleexampleexampleexampleexample' \
                      'exampleexampleexample.com/'

      expect(short_url).to be_invalid
    end

    it 'is valid when length >= 16 and <= 128' do
      short_url.url = 'http://www.example.com/'
      expect(short_url).to be_valid
    end

    it 'is invalid for an incorrect URL' do
      short_url.url = 'not a URL'
      expect(short_url).to be_invalid
    end
  end

  context 'with slug attribute' do
    it 'generates a slug when nil' do
      short_url.slug = nil
      expect(short_url).to be_valid
    end

    it 'is invalid when length < 7' do
      short_url.slug = '5'
      expect(short_url).to be_invalid
    end

    it 'is invalid when length > 7' do
      short_url.slug = '4564r454654654'
      expect(short_url).to be_invalid
    end

    it 'is valid when length is 7' do
      short_url.slug = 'abcdefg'
      expect(short_url).to be_valid
    end

    it 'must be unique' do
      short_url.slug = '1234567'
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
  end

  describe '#increment_views' do
    it 'increments `views` by 1' do
      short_url.increment_views
      expect(short_url.views).to eq 1

      short_url.increment_views
      expect(short_url.views).to eq 2
    end
  end
end
