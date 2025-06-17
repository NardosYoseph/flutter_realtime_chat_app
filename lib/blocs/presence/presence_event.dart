part of 'presence_bloc.dart';

abstract class PresenceEvent extends Equatable {
  const PresenceEvent();

  @override
  List<Object> get props => [];
}

class UpdateOnlineStatus extends PresenceEvent {
  final String userId;
  final bool isOnline;

  const UpdateOnlineStatus(this.userId, this.isOnline);

  @override
  List<Object> get props => [userId, isOnline];
}

class UpdateTypingStatus extends PresenceEvent {
  final String userId;
  final bool isTyping;

  const UpdateTypingStatus(this.userId, this.isTyping);

  @override
  List<Object> get props => [userId, isTyping];
}

class ObservePresence extends PresenceEvent {
  final String userId;

  const ObservePresence(this.userId);

  @override
  List<Object> get props => [userId];
}