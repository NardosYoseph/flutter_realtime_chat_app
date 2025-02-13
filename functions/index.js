const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.sendMessageNotification = functions.firestore
  .document('chatRooms/{chatRoomId}/messages/{messageId}')
  .onCreate(async (snap, context) => {
    const message = snap.data();
    const receiverId = message.receiverId; // Corrected from recipientId
    const senderName = message.senderName || 'Someone';
    const messageText = message.content || 'New message';

    try {
      // Fetch receiver's FCM token
      const userDoc = await admin.firestore().collection('users').doc(receiverId).get();
      
      if (!userDoc.exists) {
        console.log(`User with ID ${receiverId} not found`);
        return null;
      }

      const fcmToken = userDoc.data().fcmToken;
      if (!fcmToken) {
        console.log(`User ${receiverId} has no FCM token`);
        return null;
      }

      // Create the notification payload
      const payload = {
        notification: {
          title: `${senderName} sent you a message`,
          body: messageText,
          click_action: 'FLUTTER_NOTIFICATION_CLICK',
        },
      };

      // Send the push notification
      await admin.messaging().sendToDevice(fcmToken, payload);
      console.log(`Notification sent to user ${receiverId}`);
      
    } catch (error) {
      console.error('Error sending notification:', error);
    }
  });
