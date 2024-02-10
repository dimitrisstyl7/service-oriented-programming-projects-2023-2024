$(document).on('turbo:load', function () {

    // when conversation heading is clicked, toggle conversation
    $('body').on('click',
        '.conversation-heading, .conversation-heading-full',
        function (e) {
            e.preventDefault();
            const panel = $(this).parent();
            const panel_body = panel.find('.panel-body');
            const messages_list = panel.find('.messages-list');

            panel_body.toggle(100, function () {
                const messages_visible = $('ul', this).has('li').length;

                // Load first 10 messages if messages list is empty
                if (!messages_visible && $('.load-more-messages', this).length) {
                    $('.load-more-messages', this)[0].click();
                }
            });
        });
});

// when the link to open a conversation is clicked
// and the conversation window already exists on the page
// but it is collapsed, expand it
$('#conversations-menu').on('click', 'li', function () {
    // get conversation window's id
    const conv_id = $(this).attr('data-id');
    // get conversation's type
    let conv_type;
    if ($(this).attr('data-type') === 'private') {
        conv_type = '#pc';
    } else {
        conv_type = '#gc';
    }
    const conversation_window = $(conv_type + conv_id);

    // if conversation window exists
    if (conversation_window.length) {
        // if window is collapsed, expand it
        if (conversation_window.find('.panel-body').css('display') === 'none') {
            conversation_window.find('.conversation-heading').click();
        }
        // mark as seen by clicking it and focus textarea
        conversation_window.find('form textarea').click().focus();
    }
});