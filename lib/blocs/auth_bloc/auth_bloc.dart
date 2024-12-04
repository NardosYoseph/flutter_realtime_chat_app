import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../data/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(InitialAuthState()) {
    on<LoginEvent>(_onLogin);
   on<RegisterEvent>(_onRegister);
    }

    Future<void> _onLogin(LoginEvent event,Emitter<AuthState> emit) async{
  emit(AuthStateLoading());
  try{
    final user= await _authRepository.login(event.email, event.password);
    emit(AuthenticatedState(user.id, user.email));
  }catch(e){
      print(e);
   emit(AuthenticationErrorState("error $e"));
  }
    }

    Future<void> _onRegister(RegisterEvent event,Emitter<AuthState> emit) async{
    emit(RegisterStateLoading());
    try{
      final user=await _authRepository.register(event.email, event.password, event.username);
      print("in auth bloc");
      emit(RegistrationSuccessState());
    }catch(e){
      print(e);
      emit(RegistrationErrorState(errorMessage: "error registering"));
    }
    }
  }


