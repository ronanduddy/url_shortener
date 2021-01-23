require 'rails_helper'
require 'facades/short_urls_facade'

RSpec.describe Facades::ShortUrlsFacade do
  let(:facade) { described_class.new(user) }
  let(:user) { FactoryBot.build(:user) }

  describe '#build' do
    it { expect(facade.build).to be_a ShortUrl }
  end

  describe '#list' do
    before { allow(user).to receive(:short_urls).and_return([1, 2, 3]) }

    it { expect(facade.list).to eq [1, 2, 3] }
  end

  describe '#errors?' do
    context 'when no errors' do
      it { expect(facade.errors?).to be false }
    end

    context 'when errors present' do
      before { allow(facade).to receive(:errors).and_return(['error']) }

      it { expect(facade.errors?).to be true }
    end
  end

  describe '#errors' do
    context 'when `short_url` is not set' do
      it { expect(facade.errors).to be_nil }
    end

    context 'when `short_url` is set' do
      let(:facade) { described_class.new(user, short_url) }
      let(:short_url) { FactoryBot.build(:short_url) }

      before { allow(short_url).to receive(:errors).and_return(['error']) }

      it { expect(facade.errors).to eq ['error'] }
    end
  end
end
