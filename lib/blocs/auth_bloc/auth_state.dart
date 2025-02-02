// part of 'auth_bloc.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = InitialAuthState;
  const factory AuthState.loading() = AuthStateLoading;
  const factory AuthState.registerLoading() = RegisterStateLoading;
  const factory AuthState.authenticated({
    required String userId,
    required String email,
    required String username,
  }) = AuthenticatedState;
  const factory AuthState.unauthenticated() = Unauthenticated;
  const factory AuthState.authenticationError(String errorMessage) = AuthenticationErrorState;
  const factory AuthState.registrationSuccess() = RegistrationSuccessState;
  const factory AuthState.registrationError(String errorMessage) = RegistrationErrorState;
  const factory AuthState.loggedOut() = LoggedOutState;
}
