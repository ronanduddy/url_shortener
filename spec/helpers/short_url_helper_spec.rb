require 'rails_helper'

RSpec.describe ShortUrlHelper do
  describe '#vanity_link' do
    let(:short_url) { FactoryBot.build_stubbed(:short_url, slug: '1234567') }

    it 'produces the correct link' do
      expect(vanity_link(short_url)).to eq(
        "<a data-method=\"get\" href=\"/1234567\">http://test.host/1234567</a>"
      )
    end
  end
end
