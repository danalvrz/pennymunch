require 'rails_helper'

RSpec.describe 'Login', type: :feature do
  before :all do
    visit destroy_user_session_path
    visit '/users/sign_in'
  end

  it 'Shows username and password inputs and the "Submit" button' do
    expect(page).to have_field('user[email]')
    expect(page).to have_field('user[password]')
    expect(page).to have_button('Log in')
  end

  it 'When I click the submit button without filling nothing, the login fails.' do
    visit('/users/sign_in')
    click_button('Log in')
    expect(page.current_path).to eq('/users/sign_in')
  end

  it 'When I click the submit button after filling with incorrect data, I get an error.' do
    User.create(name: 'Testo', password: '123456', email: 'testo@mail.com')
    visit('/users/sign_in')
    fill_in 'email', with: 'testo@mail.com'
    fill_in 'password', with: '654321'
    click_button('Log in')
    expect(page.current_path).to eq('/users/sign_in')
  end

  it 'When I click the submit button after filling with correct data, I get logged in' do
    User.create(name: 'Testo', password: '123456', email: 'testo@mail.com')
    visit('/users/sign_in')
    fill_in 'email', with: 'testo@mail.com'
    fill_in 'password', with: '123456'
    click_button('Log in')
    expect(page).to have_content('Signed in successfully.')
  end
end
