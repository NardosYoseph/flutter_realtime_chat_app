import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

import '../../data/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends HydratedBloc<AuthEvent, AuthState> {
  AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(InitialAuthState()) {
    on<LoginEvent>(_onLogin);
   on<RegisterEvent>(_onRegister);
   on<LogoutEvent>((event,emit)=>emit(LoggedOutState()));
    }

   Future<void> _onLogin(LoginEvent event,Emitter<AuthState> emit) async{
  emit(AuthStateLoading());
  try{
    final user= await _authRepository.login(event.email, event.password);
    emit(AuthenticatedState(user.id, user.email,user.username));
  }catch(e){
      print(e);
   emit(AuthenticationErrorState("error signing in"));
  }
    }

    Future<void> _onRegister(RegisterEvent event,Emitter<AuthState> emit) async{
    emit(RegisterStateLoading());
    try{
      final user=await _authRepository.register(event.email, event.password, event.username);
      print("in auth bloc");
      emit(RegistrationSuccessState());
       emit(AuthenticatedState(user.id, user.email,user.username));
    }catch(e){
      print(e);
      emit(RegistrationErrorState(errorMessage: "error registering"));
    }
    }
    
  @override
AuthState? fromJson(Map<String, dynamic> json) {
  try {
    final stateType = json['stateType'] as String?;
    if (stateType == 'AuthenticatedState') {
      return AuthenticatedState(
        json['userId'] as String,
        json['email'] as String,
        json['username'] as String,
      );
    }
    return LoggedOutState();
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



