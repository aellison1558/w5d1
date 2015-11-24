require 'spec_helper'
require 'rails_helper'

feature "user_comments" do
  let(:user) { User.create(username: "test", password: "biscuits") }
  let(:comment) { FactoryGirl.create(:user_comment)}
  before(:each) do
    visit new_session_url
    fill_in 'username', with: user.username
    fill_in 'password', with: user.password
    click_on "Log In"
    visit user_url(user)
  end

  feature "user comment form" do
    scenario "user show page has comment form" do
      expect(page).to have_content("Add Comment")
    end

    scenario "add a comment" do
      fill_in 'user_comment_body', with: "First!"
      click_on 'Add Comment'
      expect(page).to have_content("First!")
    end

    scenario "validates presence of body" do
      click_on "Add Comment"
      expect(page).to have_content("Body can't be blank")
    end
  end
end
