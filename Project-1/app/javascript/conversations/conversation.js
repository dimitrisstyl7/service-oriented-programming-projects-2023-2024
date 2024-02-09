$(document).on('turbolinks:load', function () {

    // leave a gap at the top of the conversation windows' scrollbar
    $('.messages-list').scrollTop(500);

    // send a message on Enter key click and leave textarea in its original state
    $(document).on('keydown',
        '.conversation-window, .conversation',
        function (event) {
            if (event.keyCode === 13) {
                // if textarea window is not empty
                if ($.trim($('textarea', this).val())) {
                    $('.send-message', this).click();
                    event.target.value = "";
                    event.preventDefault();
                }
            }
        });

});

function calculateUnseenConversations() {
    const unseen_conv_length = $('#conversations-menu').find('.unseen-conv').length;
    const $unseen_conversations = $('#unseen-conversations');
    if (unseen_conv_length) {
        $unseen_conversations.css('visibility', 'visible');
        $unseen_conversations.text(unseen_conv_length);
    } else {
        $unseen_conversations.css('visibility', 'hidden');
        $unseen_conversations.text('');
    }
}