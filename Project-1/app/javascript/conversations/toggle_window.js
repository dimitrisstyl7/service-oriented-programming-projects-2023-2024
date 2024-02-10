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
                // if window is collapsed, hide conversation menu options
                let conversation_heading;
                if (panel_body.css('display') === 'none') {
                    panel.find('.add-people-to-chat, .add-user-to-contacts, .contact-request-sent').hide();
                    conversation_heading = panel.find('.conversation-heading');
                    conversation_heading.css('width', '360px');

                } else { // show conversation menu options
                    conversation_heading = panel.find('.conversation-heading');
                    conversation_heading.css('width', '320px');
                    panel.find('.add-people-to-chat, .add-user-to-contacts, .contact-request-sent').show();
                    // focus textarea
                    $('form textarea', this).focus();
                }
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