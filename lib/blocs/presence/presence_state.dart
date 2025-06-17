part of 'presence_bloc.dart';

abstract class PresenceState extends Equatable {
  const PresenceState();
  
  @override
  List<Object> get props => [];
}

class PresenceInitial extends PresenceState {}

class PresenceLoaded extends PresenceState {
  final bool isOnline;
  final bool isTyping;
  final DateTime? lastSeen;

  const PresenceLoaded({
    required this.isOnline,
    required this.isTyping,
    this.lastSeen,
  });

  @override
  List<Object> get props => [isOnline, isTyping, lastSeen ?? DateTime(0)];
}

class PresenceError extends PresenceState {
  final String message;

  const PresenceError(this.message);

  @override
  List<Object> get props => [message];
}