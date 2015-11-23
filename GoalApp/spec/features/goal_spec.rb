require 'spec_helper'
require 'rails_helper'

feature "makes goals" do
  before(:each) do
    visit new_session_url
    user = User.create(username: "test", password: "biscuits")
    fill_in 'username', with: "test"
    fill_in 'password', with: 'biscuits'
    click_on "Log In"
  end

  scenario "has new page" do
    visit new_goal_url
    expect(page).to have_content "Add Goal"
  end

  scenario "creates goal upon clicking Add Goal" do
    fill_in 'body', with: "Be a Better Person"
    click_on "Add Goal"
    expect(page).to have_content "Be a Better Person"
  end


end
