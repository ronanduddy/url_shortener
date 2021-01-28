require 'rails_helper'

RSpec.describe ShortUrlsFacade do
  let(:facade) { described_class.new(user) }
  let(:user) { FactoryBot.build(:user) }

  describe '#list' do
    context 'when `short_urls` is present' do
      before { allow(user).to receive(:short_urls).and_return([1, 2, 3]) }

      it { expect(facade.list).to eq [1, 2, 3] }
    end

    context 'when `short_urls` is nil' do
      before { allow(user).to receive(:short_urls).and_return(nil) }

      it { expect(facade.list).to eq [] }
    end
  end
end
