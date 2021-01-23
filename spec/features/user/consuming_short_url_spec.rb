require 'rails_helper'

RSpec.describe 'Consuming a short url', type: :feature do
  let(:user) { FactoryBot.create(:user_with_short_urls) }
  let(:short_url) { user.short_urls.first }

  scenario 'when not logged in' do
    visit vanity_path(short_url.slug)
    expect(page.current_url).to include short_url.url
  end

  scenario 'when short url does not exist' do
    visit vanity_path('12345678')
    expect(page).to have_content('Invalid short URL')
  end

  scenario 'when logged in' do
    sign_user_in

    visit vanity_path(short_url.slug)
    visit vanity_path(short_url.slug)
    expect(page.current_url).to include short_url.url

    short_url.reload

    visit short_urls_path
    expect(page).to have_content(
      "#{short_url.slug} -> #{short_url.url} 2"
    )
  end

  # TODO: pull these out from feature specs; duplication
  def sign_user_in
    visit root_path
    sign_in user
    click_on 'Sign in'
  end
end
