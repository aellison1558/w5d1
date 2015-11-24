require 'spec_helper'
require 'rails_helper'

feature "comments" do
  let(:user) { User.create(username: "test", password: "biscuits") }
  let(:goal) { FactoryGirl.create(:goal)}
  let(:comment) { FactoryGirl.create(:comment)}
  before(:each) do
    visit new_session_url
    fill_in 'username', with: user.username
    fill_in 'password', with: user.password
    click_on "Log In"
    visit goal_url(goal)
  end

  feature "goal comment form" do
    scenario "goal show page has comment form" do
      expect(page).to have_content("Add Comment")
    end

    scenario "add a comment" do
      fill_in 'comment_body', with: "First!"
      click_on 'Add Comment'
      expect(page).to have_content("First!")
    end

    scenario "validates presence of body" do
      click_on "Add Comment"
      expect(page).to have_content("Body can't be blank")
    end
  end
end
