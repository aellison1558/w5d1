require 'spec_helper'
require 'rails_helper'

feature "the signup process" do
  let(:user) { User.create(username: "test", password: "biscuits") }
  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content "New User"
  end

  feature "signing up a user" do
    before(:each) do
      visit new_user_url
      fill_in 'username', with: "test"
      fill_in 'password', with: 'biscuits'
      click_on "Create User"
    end

    scenario "redirects to home page" do
      expect(page).to have_content "Home Page"
    end


    scenario "shows username on the homepage after signup" do
      expect(page).to have_content "test"
    end

  end

  feature "logging in" do
    before(:each) do
      visit new_session_url
      fill_in 'username', with: user.username
      fill_in 'password', with: user.password
      click_on "Log In"
    end

    scenario "shows username on the homepage after login" do
      expect(page).to have_content "test"
    end
  end

  feature "logging out" do
    before(:each) do
      visit new_session_url
    end

    scenario "begins with logged out state" do
      expect(page).to have_link "Sign In"
      expect(page).to have_link "Sign Up"
    end

    scenario "doesn't show username on the homepage after logout" do
        visit new_session_url
        fill_in 'username', with: user.username
        fill_in 'password', with: user.password
        click_on "Log In"
        click_on "Sign Out"
        expect(page).to_not have_content user.username
    end

  end

end
