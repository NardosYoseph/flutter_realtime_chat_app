import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class UserStatusService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _initialStatusSet = false;
  Future<void> updateOnlineStatus(bool isOnline) async {
    final user = _auth.currentUser;
    if (user != null ) {
      await _firestore.collection('users').doc(user.uid).set({
        'isOnline': isOnline,
        'lastSeen': isOnline ? null : FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    }
  }
   Future<void> updateTypingStatus(bool isTyping) async {
      final user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).set({
      'isTyping': isTyping,
    }, SetOptions(merge: true));}
  }
   Future<void> handleAppStart() async {
    if (!_initialStatusSet) {
      await updateOnlineStatus(true);
      _initialStatusSet = true;
    }
  }
  void setupAppLifecycleListener() {
    WidgetsBinding.instance.addObserver(
      LifecycleEventHandler(
        resumeCallBack: () async => await updateOnlineStatus(true),
        pauseCallBack: () async => await updateOnlineStatus(false),
        detachCallBack: () async => await updateOnlineStatus(false),
      ),
    );
  }
}

class LifecycleEventHandler extends WidgetsBindingObserver {
  final AsyncCallback resumeCallBack;
  final AsyncCallback pauseCallBack;
  final AsyncCallback detachCallBack;

  LifecycleEventHandler({
    required this.resumeCallBack,
    required this.pauseCallBack,
    required this.detachCallBack,
  });

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        await resumeCallBack();
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
        await pauseCallBack();
        break;
      case AppLifecycleState.detached:
        await detachCallBack();
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }
}