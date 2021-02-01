require 'rails_helper'

RSpec.describe 'Viewing a short URL accesses', type: :feature do
  let(:user) { FactoryBot.create(:user_with_short_urls) }
  let(:short_url) do
    FactoryBot.create(
      :short_url,
      user: user,
      slug: '1234567',
      url: 'http://www.google.com'
    )
  end

  let(:accessed_at) { Time.new(2020, 10, 2, 6, 59) }

  before do
    FactoryBot.create(
      :url_access,
      short_url: short_url,
      created_at: accessed_at)
  end

  scenario 'when not logged in' do
    visit short_url_path(short_url)
    expect(page).to have_content('Log in')
  end

  scenario 'when logged in' do
    sign_user_in

    visit short_urls_path
    click_on '1234567'

    expect(page).to have_content('2020-10-02 06:59:00')
  end

  # TODO: pull these out from feature specs; duplication
  def sign_user_in
    visit root_path
    sign_in user
    click_on 'Sign in'
  end
end
