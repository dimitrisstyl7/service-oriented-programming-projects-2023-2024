FactoryBot.define do
  factory :group_message, class: 'Group::Message' do
    content { 'a' * 20 }
    association :conversation, factory: :group_conversation
    user
    seen_by { [create(:user).id] }

  end
end