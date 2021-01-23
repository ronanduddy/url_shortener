require 'rails_helper'

RSpec.describe 'Short URL creation', type: :feature do
  let(:user) { FactoryBot.create(:user_with_short_urls) }

  scenario 'when not logged in' do
    visit short_urls_path

    expect(page).to have_content('You need to sign in')
  end

  scenario 'when viewing a users list of URLs' do
    sign_user_in
    visit short_urls_path

    user.short_urls.each do |short_url|
      expect(page).to have_content(short_url.url)
      expect(page).to have_content(short_url.slug)
      expect(page).to have_content(short_url.views)
    end
  end

  scenario 'when creating a valid URL' do
    sign_user_in
    visit short_urls_path

    fill_in 'Url', with: 'http://www.new_url.com'
    click_on 'Create short URL'

    expect(page).to have_content('Succesfully created the short URL')
    expect(page).to have_content('http://www.new_url.com')
  end

  scenario 'when creating an invalid URL' do
    sign_user_in
    visit short_urls_path

    fill_in 'Url', with: 'invalid url'
    click_on 'Create short URL'

    expect(page).to have_content('Url is too short')
  end

  def sign_user_in
    visit root_path
    sign_in user
    click_on 'Sign in'
  end
end
