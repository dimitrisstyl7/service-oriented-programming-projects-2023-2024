$(document).on('turbolinks:load', function () {
    const $body = $('body');
    // when a contact request is accepted, mark it as accepted
    $body.on('click', '.accept-request a', function () {
        const sender_user_name = $('nav #user-name').html();
        const receiver_user_name = $(this)
            .parents('[data-user-name]')
            .attr('data-user-name');

        let requests_menu_item = $('#contacts-requests ul');
        requests_menu_item = requests_menu_item
            .find('[data-user-name="receiver_user_name"]');
        let conversation_window_request_status = $('.conversation-window')
            .find('[data-user-name="' +
                receiver_user_name +
                '"]');
        // if a conversation is opened in the messenger
        if (conversation_window_request_status.length === 0) {
            conversation_window_request_status = $('.contact-request-status');
        }
        requests_menu_item.find('.decline-request').remove();
        requests_menu_item
            .find('.accept-request')
            .replaceWith('<span class="accepted-request">Accepted</span>');
        requests_menu_item
            .removeClass('contact-request')
            .addClass('contact-request-responded');
        conversation_window_request_status
            .replaceWith('<div class="contact-request-status">Request has been accepted</div>');
        calculateContactRequests();
        // update the opposite user with your contact request response
        App.notification.contact_request_response(sender_user_name,
            receiver_user_name,
            'accepted-contact-request');
    });

    // when a contact request is declined, mark it as declined
    $body.on('click', '.decline-request a', function () {
        const sender_user_name = $('nav #user-name').html();
        const receiver_user_name = $(this)
            .parents('[data-user-name]')
            .attr('data-user-name');
        const requests_menu_item = $('#contacts-requests ul')
            .find('[data-user-name="' +
                receiver_user_name +
                '"]');
        let conversation_window_request_status = $('.conversation-window')
            .find('[data-user-name="' +
                receiver_user_name +
                '"]');
        // if a conversation is opened in the messenger
        if (conversation_window_request_status.length === 0) {
            conversation_window_request_status = $('.contact-request-status');
        }
        requests_menu_item.find('.accept-request').remove();
        requests_menu_item
            .find('.decline-request')
            .replaceWith('<span class="accepted-request">Declined</span>');
        requests_menu_item
            .removeClass('contact-request')
            .addClass('contact-request-responded');
        conversation_window_request_status
            .replaceWith('<div class="contact-request-status">Request has been declined</div>');
        calculateContactRequests();
        // update the opposite user with your contact request response
        App.notification.contact_request_response(sender_user_name,
            receiver_user_name,
            'declined-contact-request');
    });

    // when a contact request is sent
    $body.on('click', '.add-user-to-contacts-notif', function () {
        const sender_user_name = $('nav #user-name').html();
        const receiver_user_name = $(this)
            .parents('.conversation-window')
            .find('.contact-name-notif')
            .html();
        App.notification.contact_request_response(sender_user_name,
            receiver_user_name,
            'contact-request-received');
    });

    calculateContactRequests();
});

function calculateContactRequests() {
    const $contact_requests_ul = $('#contacts-requests ul')
    const $unresponded_contact_requests = $('#unresponded-contact-requests')
        .find('.contact-request')
        .length;
    if ($contact_requests_ul) {
        $unresponded_contact_requests.css('visibility', 'visible');
        $('#unresponded-contact-requests').text($contact_requests_ul);
    } else {
        $unresponded_contact_requests.css('visibility', 'hidden');
        $unresponded_contact_requests.text('');
    }
}