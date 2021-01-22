require 'rails_helper'

RSpec.describe 'User signing in', type: :feature do
  let(:user) { FactoryBot.create(:user) }

  scenario 'for existing user' do
    visit root_path
    expect(page).to_not have_selector(:link, 'Sign out')

    sign_in user
    click_on 'Sign in'

    expect(page).to have_selector(:link, 'Sign out')
  end
end
