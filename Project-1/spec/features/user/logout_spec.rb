require "rails_helper"

RSpec.feature "Logout", :type => :feature do
  let(:user) { create(:user) }

  scenario 'user successfully logs out' do
    sign_in user
    visit root_path
    find('nav #user-settings').click
    # For the dropdown link:
    find('.dropdown-menu', text: 'Log out').click
    find('.mobile-menu', text: 'Log out').click

    # For the mobile link:
    find('.mobile-menu a', text: 'Log out').click
    expect(page).to have_selector('nav a', text: 'Login')
  end

end