part of 'auth_bloc.dart';

abstract class AuthState extends Equatable{}

class InitialAuthState extends AuthState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class AuthStateLoading extends AuthState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class RegisterStateLoading extends AuthState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class AuthenticatedState extends AuthState{
    String userId;
    String email;
    String username;
    AuthenticatedState(this.userId,this.email,this.username);
    @override
    List<Object?> get props => [userId,email,username];
}
class Unauthenticated extends AuthState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class AuthenticationErrorState extends AuthState{
String errorMessage;
AuthenticationErrorState(this.errorMessage);

  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];

}
class RegistrationSuccessState extends AuthState {
  @override
  List<Object?> get props => [];
}

class RegistrationErrorState extends AuthState {
  final String errorMessage;

RegistrationErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
