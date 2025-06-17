import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'presence_event.dart';
part 'presence_state.dart';

class PresenceBloc extends Bloc<PresenceEvent, PresenceState> {
  final FirebaseFirestore _firestore;
  StreamSubscription<DocumentSnapshot>? _presenceSubscription;

  PresenceBloc({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        super(PresenceInitial()) {
    on<UpdateOnlineStatus>(_onUpdateOnlineStatus);
    on<UpdateTypingStatus>(_onUpdateTypingStatus);
    on<ObservePresence>(_onObservePresence);
  }

  Future<void> _onUpdateOnlineStatus(
    UpdateOnlineStatus event,
    Emitter<PresenceState> emit,
  ) async {
    try {
      await _firestore.collection('users').doc(event.userId).set({
        'isOnline': event.isOnline,
        'lastSeen': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      emit(PresenceError('Failed to update online status: $e'));
    }
  }

  Future<void> _onUpdateTypingStatus(
    UpdateTypingStatus event,
    Emitter<PresenceState> emit,
  ) async {
    try {
      await _firestore.collection('users').doc(event.userId).set({
        'isTyping': event.isTyping,
      }, SetOptions(merge: true));
    } catch (e) {
      emit(PresenceError('Failed to update typing status: $e'));
    }
  }

  Future<void> _onObservePresence(
    ObservePresence event,
    Emitter<PresenceState> emit,
  ) async {
    await _presenceSubscription?.cancel();
    
    _presenceSubscription = _firestore
        .collection('users')
        .doc(event.userId)
        .snapshots()
        .listen((snapshot) {
      final data = snapshot.data();
      if (data != null) {
        emit(PresenceLoaded(
          isOnline: data['isOnline'] ?? false,
          isTyping: data['isTyping'] ?? false,
          lastSeen: data['lastSeen']?.toDate(),
        ));
      }
    });
  }

  @override
  Future<void> close() {
    _presenceSubscription?.cancel();
    return super.close();
  }
}