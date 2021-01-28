require 'rails_helper'

RSpec.describe ShortUrlForm do
  let(:form) { described_class.new(params).as(FactoryBot.build(:user)) }

  describe '#save' do
    subject(:save) { form.save }

    context 'when params is nil' do
      let(:params) { nil }

      it 'does not persist and includes the correct error' do
        expect{ save }.to_not change{ ShortUrl.count }        
        expect(form.errors.messages).to include :url
      end
    end

    context 'when params contains invalid url' do
      let(:params) { { url: 'hello' } }

      it 'does not persist and includes the correct error' do
        expect{ save }.to_not change{ ShortUrl.count }
        expect(form.errors.messages).to include :url
      end
    end

    context 'when params contains valid url' do
      let(:params) { { url: 'http://www.example.com' } }

      it { expect{ save }.to change{ ShortUrl.count }.from(0).to(1) }
    end
  end
end
