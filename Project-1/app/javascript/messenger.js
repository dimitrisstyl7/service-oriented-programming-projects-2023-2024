$(document).on('turbo:load ajax:complete', function () {
    const messages_visible = $('.conversation .messages-list ul', this).has('li').length;
    const previous_messages_exist = $('.conversation .messages-list .load-more-messages', this).length;
    // Load previous messages if messages list is empty && scrollbar doesn't exist
    if (!messages_visible && previous_messages_exist) {
        $('.load-more-messages', this)[0].click();
        $('.conversation .messages-list .loading-more-messages').hide();
    }
});