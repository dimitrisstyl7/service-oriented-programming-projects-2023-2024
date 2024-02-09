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