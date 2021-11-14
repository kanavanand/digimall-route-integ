import * as functions from "firebase-functions";
import * as firebase from "firebase-admin";
firebase.initializeApp();
const fcm = firebase.messaging();
const db = firebase.firestore();

export const helloWorld = functions.https.onRequest((request, response) => {
  functions.logger.info("Hello logs!", { structuredData: true });
  response.send("Hello from Firebase!");
});

export const sendNewOrderNotification = functions.firestore
  .document("Orders/{Id}")
  .onCreate(async (snapshot) => {
    const storeId = snapshot.get("storeId");
    console.log({ storeId });
    const tokensData = await db.collection("tokens").doc(storeId).get();
    console.log({ tokensData });
    const activeTokens = tokensData.get("activeTokens");
    console.log({ activeTokens });
    const message: firebase.messaging.MulticastMessage = {
      notification: {
        title: "🎇 Hurray! New Order Placed",
        body: `Open the app to check the details.`,
      },
      tokens: activeTokens,
      android: {
        data: {
          content: JSON.stringify({
            content: {
              id: 1,
              channelKey: "new_order_noti",
              title: "🎇 New Order Placed",
              body: "Open the app to check the details.",
              notificationLayout: "BigPicture",
              largeIcon:
                "https://media.fstatic.com/kdNpUx4VBicwDuRBnhBrNmVsaKU=/full-fit-in/2https://thumbs.dreamstime.com/b/new-order-stamp-seal-watermark-distress-style-blue-vector-rubber-print-new-order-caption-dust-texture-grunge-textured-141700079.jpg90x478/media/artists/avatar/2013/08/neil-i-armstrong_a39978.jpeg",
              bigPicture:
                "https://thumbs.dreamstime.com/b/new-order-stamp-seal-watermark-distress-style-blue-vector-rubber-print-new-order-caption-dust-texture-grunge-textured-141700079.jpg",
              showWhen: true,
            },
            actionButtons: [
              {
                key: "CHECK_NOW",
                label: "Check Now",
                autoCancel: true,
              },
            ],
          }),
        },
        priority: "high",
        notification: {
          sticky: false,
          title: `🎇 Hurray! New Order Placed`,
          body: `Open the app to check the details.`,
          priority: "max",
          channelId: "new_order_noti",
          imageUrl:
            "https://thumbs.dreamstime.com/b/new-order-stamp-seal-watermark-distress-style-blue-vector-rubber-print-new-order-caption-dust-texture-grunge-textured-141700079.jpg",
        },
      },
    };
    fcm.sendMulticast(message).then((response) => {
      console.log({ response });
      console.log(response.successCount + " messages were sent successfully");
    });
  });
