require 'rails_helper'

RSpec.describe 'Home', type: :feature do
  before :each do
    visit destroy_user_session_path
    visit '/users/sign_in'
    @user1 = User.create(name: 'Testo', password: '123456', email: 'testo@mail.com')
    fill_in 'email', with: 'testo@mail.com'
    fill_in 'password', with: '123456'
    click_button('Log in')
  end

  it 'renders home page after login' do
    expect(page.current_path).to eq('/')
  end

  it 'renders home page title' do
    expect(page.find('h2', text: 'Categories')).to be_truthy
  end

  it 'renders sign out button' do
    expect(page.find('button', text: 'Sign out')).to be_truthy
  end

  it 'lets you add a new category' do
    click_link('Add new category')
    fill_in 'name', with: 'Food'
    fill_in 'icon (pick one emoji)', with: '🍔'
    click_button('Create Category')
    expect(page).to have_content('Category was successfully created.')
  end

  it 'displays the correct number of categories according to user' do
    click_link('Add new category')
    fill_in 'name', with: 'Food'
    fill_in 'icon (pick one emoji)', with: '🍔'
    click_button('Create Category')
    click_link('Add new category')
    fill_in 'name', with: 'Pets'
    fill_in 'icon (pick one emoji)', with: '🐱'
    click_button('Create Category')
    expect(page.find_all('div', class: ['category-card']).count).to eq(2)
  end

  it 'renders links for each category' do
    click_link('Add new category')
    fill_in 'name', with: 'Food'
    fill_in 'icon (pick one emoji)', with: '🍔'
    click_button('Create Category')
    click_link('Add new category')
    fill_in 'name', with: 'Pets'
    fill_in 'icon (pick one emoji)', with: '🐱'
    click_button('Create Category')
    expect(page).to have_link('Food')
    expect(page).to have_link('Pets')
  end
end
