require 'rails_helper'

RSpec.describe 'Transaction', type: :feature do
  before :each do
    visit destroy_user_session_path
    visit '/users/sign_in'
    @user1 = User.create(name: 'Testo', password: '123456', email: 'testo@mail.com')
    fill_in 'email', with: 'testo@mail.com'
    fill_in 'password', with: '123456'
    click_button('Log in')
    click_link('Add new category')
    fill_in 'name', with: 'Food'
    fill_in 'icon (pick one emoji)', with: '🍔'
    click_button('Create Category')
    click_link('Food')
  end

  it 'redirects according to category correct id' do
    @category1 = Category.find_by(name: 'Food')
    expect(page.current_path).to eq("/categories/#{@category1.id}/costs")
  end

  it 'displays correct title' do
    @category1 = Category.find_by(name: 'Food')
    expect(page).to have_content("#{@category1.name} expenses")
  end

  it 'lets you add a new transaction' do
    click_link('Add new expense')
    fill_in 'name', with: 'Pizza'
    fill_in 'amount', with: '99.99'
    click_button('Add expense')
    expect(page).to have_content('Cost was successfully created.')
  end

  it 'displays the correct number of transactions according to category' do
    click_link('Add new expense')
    fill_in 'name', with: 'Pizza'
    fill_in 'amount', with: '99.99'
    click_button('Add expense')
    click_link('Add new expense')
    fill_in 'name', with: 'Cheese'
    fill_in 'amount', with: '9.99'
    click_button('Add expense')
    expect(page.find_all('div', class: ['cost-card']).count).to eq(2)
  end

  it 'displays the total amount for that category' do
    @category1 = Category.find_by(name: 'Food')
    click_link('Add new expense')
    fill_in 'name', with: 'Pizza'
    fill_in 'amount', with: '99.99'
    click_button('Add expense')
    click_link('Add new expense')
    fill_in 'name', with: 'Cheese'
    fill_in 'amount', with: '9.99'
    click_button('Add expense')
    expect(page).to have_content("Total: $#{@category1.transaction_sum}")
  end
end
