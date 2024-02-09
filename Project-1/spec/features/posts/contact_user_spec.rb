require "rails_helper"

RSpec.feature "Contact user", :type => :feature do
  let(:user) { create(:user) }
  let(:category) { create(:category, name: 'Arts', branch: 'hobby') }
  let(:post) { create(:post, category_id: category.id) }

  context 'logged in user' do
    before(:each) do
      sign_in user
    end

    scenario 'sees an already contacted message' do
      create(:private_conversation_with_messages,
             recipient_id: post.user.id,
             sender_id: user.id)
      visit post_path(post)
      expect(page).to have_selector(
                        '.contact-user .contacted-user',
                        text: 'You are already in touch with this user')
    end
  end

  context 'non-logged in user' do
    scenario 'sees a login required message to contact a user' do
      visit post_path(post)
      expect(page).to have_selector('div', text: 'To contact the user you have to')
    end
  end
end