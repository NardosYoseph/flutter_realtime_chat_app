import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../service/user_status_service.dart';

class AppAuthProvider {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final UserStatusService _userStatusService ;

  AppAuthProvider({FirebaseAuth? firebase_auth, GoogleSignIn? googleSignIn, UserStatusService? userStatusService})
      : _googleSignIn = googleSignIn ?? GoogleSignIn(),
  _firebaseAuth=firebase_auth??FirebaseAuth.instance,
  _userStatusService = userStatusService ?? UserStatusService();

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
    
await _userStatusService.updateOnlineStatus(true);
      return userData;

  } catch (e) {
    throw Exception('Failed to sign up: $e');
  }
}
Future<UserCredential> signInWithGoogle() async {
    try {
      // Trigger the Google Sign In flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception('Google sign-in cancelled');
      }

      // Obtain the auth details
      final GoogleSignInAuthentication googleAuth = 
          await googleUser.authentication;

      // Create a credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase
      final UserCredential userCredential = 
          await _firebaseAuth.signInWithCredential(credential);

      // Update user status
      await _userStatusService.updateOnlineStatus(true);

      // Save user data to Firestore if new user
      if (userCredential.additionalUserInfo?.isNewUser ?? false) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'email': userCredential.user!.email,
          'username': userCredential.user!.displayName ?? 'Google User',
          'photoUrl': userCredential.user!.photoURL,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      // Get FCM token
      String? fcmToken = await FirebaseMessaging.instance.getToken();
      if (fcmToken != null) {
        saveFCMToken(userCredential.user!.uid, fcmToken);
      }

      return userCredential;
    } catch (e) {
      throw Exception('Google sign-in failed: $e');
    }
  }
Future<UserCredential> login(String email, String password) async {
  try {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
await _userStatusService.updateOnlineStatus(true);
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
  Future<void> logout() async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      await _userStatusService.updateOnlineStatus(false);
      await _firebaseAuth.signOut();
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