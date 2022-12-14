require 'rails_helper'

feature 'User management' do
  # let!(:admin) do
  #   create(:user, email: 'admin@test.com', password: 'secret', password_confirmation: 'secret', admin: true)
  # end

  # scenario "adds a new user", js: true do # con js true no anda, Capybara no toma el admin
  scenario "adds a new user" do         # rspec normal anda
    admin = create(:admin)       # Validation failed: Email has already been taken
    sign_in admin
    
    # visit root_path
    # admin = User.new
    # admin.password = 'secret'

    # expect(page).to_not have_content("Email has already been taken")
    # expect(page).to_not have_content("Email or password is invalid")
    # expect(page).to have_content("No contacts found")
    
    expect{
      click_link 'Users'
      # click_link 'Userinos'
      # click_link 'Log In'
      click_link 'New User'
      fill_in 'Email', with: 'newuser@example.com'
      find('#password').fill_in 'Password', with: 'secret123'
      find('#password_confirmation').fill_in 'Password confirmation',
        with: 'secret123'
      click_button 'Create User'
    }.to change(User, :count).by(1)

    expect(current_path).to eq users_path
    expect(page).to have_content 'New user created'
    within 'h1' do
      expect(page).to have_content 'Users'
    end
    expect(page).to have_content 'newuser@example.com'

  end
end
