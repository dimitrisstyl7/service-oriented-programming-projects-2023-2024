require 'rails_helper'

RSpec.describe Shared::ConversationsHelper, :type => :helper do
  context '#private_conv_seen_status' do
    it 'returns an empty string' do
      current_user = create(:user)
      conversation = create(:private_conversation)
      create(:private_message,
             conversation_id: conversation.id,
             seen: false,
             user_id: current_user.id)
      allow(view).to receive(:current_user).and_return(current_user)
      expect(helper.private_conv_seen_status(conversation)).to eq ''
    end

    it 'returns an empty string' do
      current_user = create(:user)
      recipient = create(:user)
      conversation = create(:private_conversation)
      create(:private_message,
             conversation_id: conversation.id,
             seen: true,
             user_id: recipient.id)
      allow(view).to receive(:current_user).and_return(current_user)
      expect(helper.private_conv_seen_status(conversation)).to eq ''
    end

    it 'returns unseen-conv status' do
      current_user = create(:user)
      recipient = create(:user)
      conversation = create(:private_conversation)
      create(:private_message,
             conversation_id: conversation.id,
             seen: false,
             user_id: recipient.id)
      allow(view).to receive(:current_user).and_return(current_user)
      expect(helper.private_conv_seen_status(conversation)).to eq 'unseen-conv'
    end
  end

  context '#group_conv_seen_status' do
    it 'returns unseen-conv status' do
      conversation = create(:group_conversation, messages: [create(:group_message)])
      current_user = create(:user)
      allow(helper).to receive(:current_user).and_return(current_user)
      expect(helper.group_conv_seen_status(conversation, current_user)).to eq 'unseen-conv'
    end

    it 'returns an empty string' do
      user = nil
      conversation = create(:group_conversation, messages: [create(:group_message)])
      allow(helper).to receive(:current_user).and_return(user)
      expect(helper.group_conv_seen_status(conversation, user)).to eq ''
    end

    it 'returns an empty string' do
      user = create(:user)
      conversation = create(:group_conversation, messages: [])
      message = build(:group_message, conversation_id: conversation.id)
      message.seen_by << user.id
      message.save
      conversation.messages << message
      allow(helper).to receive(:current_user).and_return(user)
      expect(helper.group_conv_seen_status(conversation, user)).to eq ''
    end
  end
end