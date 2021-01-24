require 'rails_helper'

RSpec.describe 'Consuming a short url', type: :feature do
  let(:user) { FactoryBot.create(:user_with_short_urls) }
  let(:short_url) do
    FactoryBot.create(
      :short_url,
      user: user,
      slug: '1234567',
      url: 'http://www.google.com'
    )
  end

  scenario 'when not logged in' do
    visit vanity_path(short_url.slug)
    expect(page.current_url).to include 'http://www.google.com'
    # TODO: investigate why page text has not updated
    # expect(page.text).to_not eq 'Welcome to the URL shortener app. Please Sign in or Register.'
  end

  scenario 'when short url does not exist' do
    visit vanity_path('abcdefg')
    expect(page).to have_content('Invalid short URL')
  end

  scenario 'when logged in' do
    sign_user_in

    visit vanity_path(short_url.slug)
    visit vanity_path(short_url.slug)
    expect(page.current_url).to include 'http://www.google.com'

    short_url.reload

    visit short_urls_path
    row = page.find("tr##{short_url.id}")
    expect(row).to have_content('1234567 http://www.google.com 2 http://www.example.com/1234567')
  end

  # TODO: pull these out from feature specs; duplication
  def sign_user_in
    visit root_path
    sign_in user
    click_on 'Sign in'
  end
end
