require 'rails_helper'

RSpec.describe 'Registering a user', type: :feature do
  scenario 'using email and password' do
    visit root_path
    click_on 'Register'

    fill_in 'Email', with: 'example@test.com'
    fill_in 'Password', with: 'password123'
    fill_in 'user_password_confirmation', with: 'password123'
    click_on 'Sign up'

    expect(page).to have_content('You have signed up successfully')
  end
end
