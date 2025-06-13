import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class AuthProvider {
  FirebaseAuth _firebaseAuth;
  AuthProvider({FirebaseAuth? firebase_auth})
  :_firebaseAuth=firebase_auth??FirebaseAuth.instance;
Future<UserCredential> SignUp(String email, String password, String username) async {
  print("In provider class");

  try {
    // Create the user in Firebase Authentication
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    print("In provider class, try success");
    await userCredential.user?.updateDisplayName(username);
    print("In provider, update displayName success");

    final uid = userCredential.user?.uid;

    if (uid == null) {
      throw Exception('User UID not found');
    }
   final user= await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'username': username,
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
    });

    print("User profile saved to Firestore");
  final userData = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
       String? fcmToken = await FirebaseMessaging.instance.getToken();

    if (fcmToken != null) {
      // Save the FCM token to Firestore
      saveFCMToken(userData.user!.uid, fcmToken);
    }

      return userData;

  } catch (e) {
    throw Exception('Failed to sign up: $e');
  }
}

Future<UserCredential> login(String email, String password) async {
  try {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Get FCM token
    String? fcmToken = await FirebaseMessaging.instance.getToken();

    if (fcmToken != null) {
      // Save the FCM token to Firestore
      saveFCMToken(userCredential.user!.uid, fcmToken);
    }

    return userCredential;
  } catch (e) {
    throw Exception('Failed to log in: $e');
  }
}

void saveFCMToken(String userId, String fcmToken) {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  _firestore.collection('users').doc(userId).set({
    'fcmToken': fcmToken,
  }, SetOptions(merge: true)).then((_) {
    print("FCM Token updated successfully");
  }).catchError((error) {
    print("Error updating FCM Token: $error");
  });
}
}