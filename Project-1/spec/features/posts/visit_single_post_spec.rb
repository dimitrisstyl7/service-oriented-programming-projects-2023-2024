require "rails_helper"

RSpec.feature "Visit single post", :type => :feature do
  let(:user) { create(:user) }
  let(:post) { create(:post, category: create(:category, branch: 'study')) }

  scenario "User goes to a single post from the home page" do
    post
    visit root_path
    page.find('.single-post-card').click
    expect(page).to have_selector('body .modal')
    page.find('.interested a') do
      click_link "Open modal"
    end
    expect(page).to have_selector('#single-post-content p', text: post.content)
  end

end