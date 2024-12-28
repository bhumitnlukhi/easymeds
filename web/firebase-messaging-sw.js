importScripts("https://www.gstatic.com/firebasejs/8.10.1/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.1/firebase-messaging.js");

firebase.initializeApp({
  apiKey: "AIzaSyBT8u6T7FN7nPT_7v1D5Evsje1r7Iv8L14",
    authDomain: "easymeds-by-initlync.firebaseapp.com",
    projectId: "easymeds-by-initlync",
    storageBucket: "easymeds-by-initlync.firebasestorage.app",
    messagingSenderId: "256398666518",
    appId: "1:256398666518:web:1456b73ee036a2e00a3e37",
    measurementId: "G-34B4E72YTQ"
});

const messaging = firebase.messaging();

messaging.setBackgroundMessageHandler(function (payload) {
    const promiseChain = clients
        .matchAll({
            type: "window",
            includeUncontrolled: true
        })
        .then(windowClients => {
            for (let i = 0; i < windowClients.length; i++) {
                const windowClient = windowClients[i];
                windowClient.postMessage(payload);
            }
        })
        .then(() => {
            const title = payload.notification.title;
            const options = {
                body: payload.notification.score
              };
            return registration.showNotification(title, options);
        });
    return promiseChain;
});
self.addEventListener('notificationclick', function (event) {
    console.log('notification received: ', event)
});