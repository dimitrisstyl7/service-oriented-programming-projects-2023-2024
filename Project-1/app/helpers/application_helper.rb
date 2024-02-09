require_relative 'navigation_helper'

module ApplicationHelper
  include NavigationHelper
  include PostsHelper
  include Private::ConversationsHelper
  include Private::MessagesHelper

  def private_conversations_windows
    params[:controller] != 'messengers' ? @private_conversations_windows : []
  end
end