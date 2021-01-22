require 'rails_helper'

RSpec.describe 'Going to the application root', type: :feature do
  scenario 'normal flow' do
    visit root_path
    expect(page).to have_selector(:link, 'Sign in')
    expect(page).to have_selector(:link, 'Register')
  end
end
