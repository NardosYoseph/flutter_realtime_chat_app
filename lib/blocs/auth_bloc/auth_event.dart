part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable{}
class LoginEvent extends AuthEvent{
  String email;
  String password;
  LoginEvent(this.email, this.password);
  
  @override
  // TODO: implement props
  List<Object?> get props => [email,password];
  
}
class RegisterEvent extends AuthEvent{
  String username;
  String email;
  String password;
RegisterEvent(this.username,this.email,this.password);

  @override
  // TODO: implement props
  List<Object?> get props => [username,email,password];

}
class LogoutEvent extends AuthEvent{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}