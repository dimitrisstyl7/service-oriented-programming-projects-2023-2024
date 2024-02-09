App.private_conversation = App.cable.subscriptions.create("Private::ConversationChannel", {
    connected: function () {
    },
    disconnected: function () {
    },
    received: function (data) {
    }
});