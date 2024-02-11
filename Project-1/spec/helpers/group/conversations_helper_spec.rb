require 'rails_helper'

RSpec.describe Group::ConversationsHelper, :type => :helper do
  context '#load_group_messages_partial_path' do
    let(:conversation) { create(:group_conversation) }

    it "returns load_messages partial's path" do
      create_list(:group_message, 2, conversation_id: conversation.id)
      expect(helper.load_group_messages_partial_path(conversation)).to eq(
                                                                         'group/conversations/conversation/messages_list/link_to_previous_messages'
                                                                       )
    end

    it "returns an empty partial's path" do
      expect(helper.load_group_messages_partial_path(conversation)).to eq 'shared/empty_partial'
    end
  end
end