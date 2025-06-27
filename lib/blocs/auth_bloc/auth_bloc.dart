import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import 'package:real_time_chat_app/blocs/auth_bloc/auth_event.dart';
import 'package:real_time_chat_app/blocs/auth_bloc/auth_state.dart';
import 'package:real_time_chat_app/data/repositories/user_repository.dart';

import '../../data/repositories/auth_repository.dart';


class AuthBloc extends HydratedBloc<AuthEvent, AuthState> {
  AuthRepository _authRepository;
 UserRepository _userRepository;
  AuthBloc(this._authRepository, this._userRepository) : super(const AuthState.initial()) {
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
    on<LogoutEvent>((event, emit) async{
      try{
    await _authRepository.logout();
    emit(AuthState.loggedOut());
  }catch(e){
      print(e);
  }
  });
    on<GoogleSignInEvent>(_handleGoogleSignIn);
  
  }
  Future<void> _handleGoogleSignIn(GoogleSignInEvent event,Emitter<AuthState> emit) async {
    try {
      emit(const AuthState.loading());
      final userCredential = await _authRepository.signInWithGoogle();

      final user = await _userRepository.fetchUser(userCredential.user?.uid ?? '');


      emit(AuthState.authenticated(
        userId: user.id,
        email: user.email,
        username: user.username,
      ));
    } catch (e) {
      emit(AuthState.authenticationError(e.toString()));
    }
  }

   Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async{
  emit(const AuthState.loading());
  try{
    final user= await _authRepository.login(event.email, event.password);
    emit(AuthState.authenticated( userId: user.id, email: user.email, username: user.username));
  }catch(e){
      print(e);
   emit(const AuthState.authenticationError("error signing in"));
  }
    }

    Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async{
    emit(const AuthState.registerLoading());
    try{
      final user=await _authRepository.register(event.email, event.password, event.username);
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
}}




