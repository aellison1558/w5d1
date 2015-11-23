require 'spec_helper'
require 'rails_helper'

feature "goals" do
  let(:user) { User.create(username: "test", password: "biscuits") }
  let(:goals) do
     5.times { FactoryGirl.create(:goal) }
     FactoryGirl.create(:better_person)
   end

  feature "makes goals" do
    before(:each) do
      visit new_session_url
      user
      fill_in 'username', with: "test"
      fill_in 'password', with: 'biscuits'
      click_on "Log In"
      visit new_goal_url
    end

    scenario "has new page" do
      expect(page).to have_content "Add Goal"
    end

    scenario "creates goal upon clicking Add Goal" do

      fill_in 'body', with: "Be a Better Person"
      click_on "Add Goal"
      expect(page).to have_content "Be a Better Person"
    end

    scenario "validates presence of body" do
      click_on "Add Goal"
      expect(page).to have_content "Body can't be blank"
    end

  end

  feature "shows user goals" do
    before(:each) do
      visit new_session_url
      user
      fill_in 'username', with: "test"
      fill_in 'password', with: 'biscuits'
      click_on "Log In"
      goals #create some goals
      visit user_goals_url(user)
    end

    scenario "displays goals" do
      expect(page).to have_content "Be a Better Person"
    end

    scenario "displays user" do
      expect(page).to have_content "test"
    end

    scenario "has a link to new" do
      expect(page).to have_link "Add Goal", href: new_goal_url
    end

    scenario "redirects if not logged in" do
      click_on "Sign Out"
      visit user_goals_url(user)
      expect(page).to have_button "Log In"
    end
  end
end
