class Group::ConversationsController < ApplicationController
  def create
    @conversation = create_group_conversation
    add_to_conversations unless already_added?

    respond_to do |format|
      format.js
    end
  end
end
