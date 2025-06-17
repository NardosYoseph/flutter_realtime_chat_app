import 'package:cloud_firestore/cloud_firestore.dart';

class PresenceRepository {
  final FirebaseFirestore _firestore;

  PresenceRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> updateTypingStatus(String userId, bool isTyping) async {
    await _firestore.collection('users').doc(userId).set({
      'isTyping': isTyping,
    }, SetOptions(merge: true));
  }
}
