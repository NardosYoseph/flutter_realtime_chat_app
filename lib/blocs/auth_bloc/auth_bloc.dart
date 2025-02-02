import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import 'package:real_time_chat_app/blocs/auth_bloc/auth_event.dart';
import 'package:real_time_chat_app/blocs/auth_bloc/auth_state.dart';

import '../../data/repositories/auth_repository.dart';

// part 'auth_event.dart';
// part 'auth_state.dart';

class AuthBloc extends HydratedBloc<AuthEvent, AuthState> {
  AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(const AuthState.initial()) {
    on<AuthEvent>((event,emit){
      event.when(
        login: (email, password) => _onLogin(email, password, emit),
    register: (username, email, password) => _onRegister(username, email, password, emit),
    logout: () => emit(const AuthState.loggedOut()),
      );
    });
    }

   Future<void> _onLogin(String email, String password,Emitter<AuthState> emit) async{
  emit(const AuthState.loading());
  try{
    final user= await _authRepository.login(email,password);
    emit(AuthState.authenticated( userId: user.id, email: user.email, username: user.username));
  }catch(e){
      print(e);
   emit(const AuthState.authenticationError("error signing in"));
  }
    }

    Future<void> _onRegister(String username,String email, String password,Emitter<AuthState> emit) async{
    emit(const AuthState.registerLoading());
    try{
      final user=await _authRepository.register(email, password, username);
      print("in auth bloc");
      emit(const AuthState.registrationSuccess());
       emit(AuthState.authenticated(
        userId: user.id, email: user.email, username: user.username));
    }catch(e){
      print(e);
      emit(const AuthState.registrationError("error registering"));
    }
    }
    
  @override
AuthState? fromJson(Map<String, dynamic> json) {
  try {
    final stateType = json['stateType'] as String?;
    if (stateType == 'AuthenticatedState') {
      return AuthState.authenticated(
      userId:  json['userId'] as String,
       email: json['email'] as String,
       username: json['username'] as String,
      );
    }
    return const LoggedOutState();
  } catch (e) {
    print("Error deserializing AuthState: $e");
    return null;
  }
}

@override
Map<String, dynamic>? toJson(AuthState state) {
  try {
    if (state is AuthenticatedState) {
      return {
        'stateType': 'AuthenticatedState',
        'userId': state.userId,
        'email': state.email,
        'username': state.username,
      };
    }
    return {'stateType': 'LoggedOutState'};
  } catch (e) {
    print("Error serializing AuthState: $e");
    return null;
  }
}
}



