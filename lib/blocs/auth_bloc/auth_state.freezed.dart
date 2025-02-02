// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AuthState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() registerLoading,
    required TResult Function(String userId, String email, String username)
        authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(String errorMessage) authenticationError,
    required TResult Function() registrationSuccess,
    required TResult Function(String errorMessage) registrationError,
    required TResult Function() loggedOut,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? registerLoading,
    TResult? Function(String userId, String email, String username)?
        authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(String errorMessage)? authenticationError,
    TResult? Function()? registrationSuccess,
    TResult? Function(String errorMessage)? registrationError,
    TResult? Function()? loggedOut,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? registerLoading,
    TResult Function(String userId, String email, String username)?
        authenticated,
    TResult Function()? unauthenticated,
    TResult Function(String errorMessage)? authenticationError,
    TResult Function()? registrationSuccess,
    TResult Function(String errorMessage)? registrationError,
    TResult Function()? loggedOut,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitialAuthState value) initial,
    required TResult Function(AuthStateLoading value) loading,
    required TResult Function(RegisterStateLoading value) registerLoading,
    required TResult Function(AuthenticatedState value) authenticated,
    required TResult Function(Unauthenticated value) unauthenticated,
    required TResult Function(AuthenticationErrorState value)
        authenticationError,
    required TResult Function(RegistrationSuccessState value)
        registrationSuccess,
    required TResult Function(RegistrationErrorState value) registrationError,
    required TResult Function(LoggedOutState value) loggedOut,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitialAuthState value)? initial,
    TResult? Function(AuthStateLoading value)? loading,
    TResult? Function(RegisterStateLoading value)? registerLoading,
    TResult? Function(AuthenticatedState value)? authenticated,
    TResult? Function(Unauthenticated value)? unauthenticated,
    TResult? Function(AuthenticationErrorState value)? authenticationError,
    TResult? Function(RegistrationSuccessState value)? registrationSuccess,
    TResult? Function(RegistrationErrorState value)? registrationError,
    TResult? Function(LoggedOutState value)? loggedOut,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitialAuthState value)? initial,
    TResult Function(AuthStateLoading value)? loading,
    TResult Function(RegisterStateLoading value)? registerLoading,
    TResult Function(AuthenticatedState value)? authenticated,
    TResult Function(Unauthenticated value)? unauthenticated,
    TResult Function(AuthenticationErrorState value)? authenticationError,
    TResult Function(RegistrationSuccessState value)? registrationSuccess,
    TResult Function(RegistrationErrorState value)? registrationError,
    TResult Function(LoggedOutState value)? loggedOut,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res, AuthState>;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res, $Val extends AuthState>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialAuthStateImplCopyWith<$Res> {
  factory _$$InitialAuthStateImplCopyWith(_$InitialAuthStateImpl value,
          $Res Function(_$InitialAuthStateImpl) then) =
      __$$InitialAuthStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialAuthStateImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$InitialAuthStateImpl>
    implements _$$InitialAuthStateImplCopyWith<$Res> {
  __$$InitialAuthStateImplCopyWithImpl(_$InitialAuthStateImpl _value,
      $Res Function(_$InitialAuthStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialAuthStateImpl implements InitialAuthState {
  const _$InitialAuthStateImpl();

  @override
  String toString() {
    return 'AuthState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialAuthStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() registerLoading,
    required TResult Function(String userId, String email, String username)
        authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(String errorMessage) authenticationError,
    required TResult Function() registrationSuccess,
    required TResult Function(String errorMessage) registrationError,
    required TResult Function() loggedOut,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? registerLoading,
    TResult? Function(String userId, String email, String username)?
        authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(String errorMessage)? authenticationError,
    TResult? Function()? registrationSuccess,
    TResult? Function(String errorMessage)? registrationError,
    TResult? Function()? loggedOut,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? registerLoading,
    TResult Function(String userId, String email, String username)?
        authenticated,
    TResult Function()? unauthenticated,
    TResult Function(String errorMessage)? authenticationError,
    TResult Function()? registrationSuccess,
    TResult Function(String errorMessage)? registrationError,
    TResult Function()? loggedOut,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitialAuthState value) initial,
    required TResult Function(AuthStateLoading value) loading,
    required TResult Function(RegisterStateLoading value) registerLoading,
    required TResult Function(AuthenticatedState value) authenticated,
    required TResult Function(Unauthenticated value) unauthenticated,
    required TResult Function(AuthenticationErrorState value)
        authenticationError,
    required TResult Function(RegistrationSuccessState value)
        registrationSuccess,
    required TResult Function(RegistrationErrorState value) registrationError,
    required TResult Function(LoggedOutState value) loggedOut,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitialAuthState value)? initial,
    TResult? Function(AuthStateLoading value)? loading,
    TResult? Function(RegisterStateLoading value)? registerLoading,
    TResult? Function(AuthenticatedState value)? authenticated,
    TResult? Function(Unauthenticated value)? unauthenticated,
    TResult? Function(AuthenticationErrorState value)? authenticationError,
    TResult? Function(RegistrationSuccessState value)? registrationSuccess,
    TResult? Function(RegistrationErrorState value)? registrationError,
    TResult? Function(LoggedOutState value)? loggedOut,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitialAuthState value)? initial,
    TResult Function(AuthStateLoading value)? loading,
    TResult Function(RegisterStateLoading value)? registerLoading,
    TResult Function(AuthenticatedState value)? authenticated,
    TResult Function(Unauthenticated value)? unauthenticated,
    TResult Function(AuthenticationErrorState value)? authenticationError,
    TResult Function(RegistrationSuccessState value)? registrationSuccess,
    TResult Function(RegistrationErrorState value)? registrationError,
    TResult Function(LoggedOutState value)? loggedOut,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class InitialAuthState implements AuthState {
  const factory InitialAuthState() = _$InitialAuthStateImpl;
}

/// @nodoc
abstract class _$$AuthStateLoadingImplCopyWith<$Res> {
  factory _$$AuthStateLoadingImplCopyWith(_$AuthStateLoadingImpl value,
          $Res Function(_$AuthStateLoadingImpl) then) =
      __$$AuthStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthStateLoadingImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthStateLoadingImpl>
    implements _$$AuthStateLoadingImplCopyWith<$Res> {
  __$$AuthStateLoadingImplCopyWithImpl(_$AuthStateLoadingImpl _value,
      $Res Function(_$AuthStateLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AuthStateLoadingImpl implements AuthStateLoading {
  const _$AuthStateLoadingImpl();

  @override
  String toString() {
    return 'AuthState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AuthStateLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() registerLoading,
    required TResult Function(String userId, String email, String username)
        authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(String errorMessage) authenticationError,
    required TResult Function() registrationSuccess,
    required TResult Function(String errorMessage) registrationError,
    required TResult Function() loggedOut,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? registerLoading,
    TResult? Function(String userId, String email, String username)?
        authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(String errorMessage)? authenticationError,
    TResult? Function()? registrationSuccess,
    TResult? Function(String errorMessage)? registrationError,
    TResult? Function()? loggedOut,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? registerLoading,
    TResult Function(String userId, String email, String username)?
        authenticated,
    TResult Function()? unauthenticated,
    TResult Function(String errorMessage)? authenticationError,
    TResult Function()? registrationSuccess,
    TResult Function(String errorMessage)? registrationError,
    TResult Function()? loggedOut,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitialAuthState value) initial,
    required TResult Function(AuthStateLoading value) loading,
    required TResult Function(RegisterStateLoading value) registerLoading,
    required TResult Function(AuthenticatedState value) authenticated,
    required TResult Function(Unauthenticated value) unauthenticated,
    required TResult Function(AuthenticationErrorState value)
        authenticationError,
    required TResult Function(RegistrationSuccessState value)
        registrationSuccess,
    required TResult Function(RegistrationErrorState value) registrationError,
    required TResult Function(LoggedOutState value) loggedOut,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitialAuthState value)? initial,
    TResult? Function(AuthStateLoading value)? loading,
    TResult? Function(RegisterStateLoading value)? registerLoading,
    TResult? Function(AuthenticatedState value)? authenticated,
    TResult? Function(Unauthenticated value)? unauthenticated,
    TResult? Function(AuthenticationErrorState value)? authenticationError,
    TResult? Function(RegistrationSuccessState value)? registrationSuccess,
    TResult? Function(RegistrationErrorState value)? registrationError,
    TResult? Function(LoggedOutState value)? loggedOut,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitialAuthState value)? initial,
    TResult Function(AuthStateLoading value)? loading,
    TResult Function(RegisterStateLoading value)? registerLoading,
    TResult Function(AuthenticatedState value)? authenticated,
    TResult Function(Unauthenticated value)? unauthenticated,
    TResult Function(AuthenticationErrorState value)? authenticationError,
    TResult Function(RegistrationSuccessState value)? registrationSuccess,
    TResult Function(RegistrationErrorState value)? registrationError,
    TResult Function(LoggedOutState value)? loggedOut,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class AuthStateLoading implements AuthState {
  const factory AuthStateLoading() = _$AuthStateLoadingImpl;
}

/// @nodoc
abstract class _$$RegisterStateLoadingImplCopyWith<$Res> {
  factory _$$RegisterStateLoadingImplCopyWith(_$RegisterStateLoadingImpl value,
          $Res Function(_$RegisterStateLoadingImpl) then) =
      __$$RegisterStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RegisterStateLoadingImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$RegisterStateLoadingImpl>
    implements _$$RegisterStateLoadingImplCopyWith<$Res> {
  __$$RegisterStateLoadingImplCopyWithImpl(_$RegisterStateLoadingImpl _value,
      $Res Function(_$RegisterStateLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RegisterStateLoadingImpl implements RegisterStateLoading {
  const _$RegisterStateLoadingImpl();

  @override
  String toString() {
    return 'AuthState.registerLoading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterStateLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() registerLoading,
    required TResult Function(String userId, String email, String username)
        authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(String errorMessage) authenticationError,
    required TResult Function() registrationSuccess,
    required TResult Function(String errorMessage) registrationError,
    required TResult Function() loggedOut,
  }) {
    return registerLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? registerLoading,
    TResult? Function(String userId, String email, String username)?
        authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(String errorMessage)? authenticationError,
    TResult? Function()? registrationSuccess,
    TResult? Function(String errorMessage)? registrationError,
    TResult? Function()? loggedOut,
  }) {
    return registerLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? registerLoading,
    TResult Function(String userId, String email, String username)?
        authenticated,
    TResult Function()? unauthenticated,
    TResult Function(String errorMessage)? authenticationError,
    TResult Function()? registrationSuccess,
    TResult Function(String errorMessage)? registrationError,
    TResult Function()? loggedOut,
    required TResult orElse(),
  }) {
    if (registerLoading != null) {
      return registerLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitialAuthState value) initial,
    required TResult Function(AuthStateLoading value) loading,
    required TResult Function(RegisterStateLoading value) registerLoading,
    required TResult Function(AuthenticatedState value) authenticated,
    required TResult Function(Unauthenticated value) unauthenticated,
    required TResult Function(AuthenticationErrorState value)
        authenticationError,
    required TResult Function(RegistrationSuccessState value)
        registrationSuccess,
    required TResult Function(RegistrationErrorState value) registrationError,
    required TResult Function(LoggedOutState value) loggedOut,
  }) {
    return registerLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitialAuthState value)? initial,
    TResult? Function(AuthStateLoading value)? loading,
    TResult? Function(RegisterStateLoading value)? registerLoading,
    TResult? Function(AuthenticatedState value)? authenticated,
    TResult? Function(Unauthenticated value)? unauthenticated,
    TResult? Function(AuthenticationErrorState value)? authenticationError,
    TResult? Function(RegistrationSuccessState value)? registrationSuccess,
    TResult? Function(RegistrationErrorState value)? registrationError,
    TResult? Function(LoggedOutState value)? loggedOut,
  }) {
    return registerLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitialAuthState value)? initial,
    TResult Function(AuthStateLoading value)? loading,
    TResult Function(RegisterStateLoading value)? registerLoading,
    TResult Function(AuthenticatedState value)? authenticated,
    TResult Function(Unauthenticated value)? unauthenticated,
    TResult Function(AuthenticationErrorState value)? authenticationError,
    TResult Function(RegistrationSuccessState value)? registrationSuccess,
    TResult Function(RegistrationErrorState value)? registrationError,
    TResult Function(LoggedOutState value)? loggedOut,
    required TResult orElse(),
  }) {
    if (registerLoading != null) {
      return registerLoading(this);
    }
    return orElse();
  }
}

abstract class RegisterStateLoading implements AuthState {
  const factory RegisterStateLoading() = _$RegisterStateLoadingImpl;
}

/// @nodoc
abstract class _$$AuthenticatedStateImplCopyWith<$Res> {
  factory _$$AuthenticatedStateImplCopyWith(_$AuthenticatedStateImpl value,
          $Res Function(_$AuthenticatedStateImpl) then) =
      __$$AuthenticatedStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String userId, String email, String username});
}

/// @nodoc
class __$$AuthenticatedStateImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthenticatedStateImpl>
    implements _$$AuthenticatedStateImplCopyWith<$Res> {
  __$$AuthenticatedStateImplCopyWithImpl(_$AuthenticatedStateImpl _value,
      $Res Function(_$AuthenticatedStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? email = null,
    Object? username = null,
  }) {
    return _then(_$AuthenticatedStateImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AuthenticatedStateImpl implements AuthenticatedState {
  const _$AuthenticatedStateImpl(
      {required this.userId, required this.email, required this.username});

  @override
  final String userId;
  @override
  final String email;
  @override
  final String username;

  @override
  String toString() {
    return 'AuthState.authenticated(userId: $userId, email: $email, username: $username)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticatedStateImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.username, username) ||
                other.username == username));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userId, email, username);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthenticatedStateImplCopyWith<_$AuthenticatedStateImpl> get copyWith =>
      __$$AuthenticatedStateImplCopyWithImpl<_$AuthenticatedStateImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() registerLoading,
    required TResult Function(String userId, String email, String username)
        authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(String errorMessage) authenticationError,
    required TResult Function() registrationSuccess,
    required TResult Function(String errorMessage) registrationError,
    required TResult Function() loggedOut,
  }) {
    return authenticated(userId, email, username);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? registerLoading,
    TResult? Function(String userId, String email, String username)?
        authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(String errorMessage)? authenticationError,
    TResult? Function()? registrationSuccess,
    TResult? Function(String errorMessage)? registrationError,
    TResult? Function()? loggedOut,
  }) {
    return authenticated?.call(userId, email, username);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? registerLoading,
    TResult Function(String userId, String email, String username)?
        authenticated,
    TResult Function()? unauthenticated,
    TResult Function(String errorMessage)? authenticationError,
    TResult Function()? registrationSuccess,
    TResult Function(String errorMessage)? registrationError,
    TResult Function()? loggedOut,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(userId, email, username);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitialAuthState value) initial,
    required TResult Function(AuthStateLoading value) loading,
    required TResult Function(RegisterStateLoading value) registerLoading,
    required TResult Function(AuthenticatedState value) authenticated,
    required TResult Function(Unauthenticated value) unauthenticated,
    required TResult Function(AuthenticationErrorState value)
        authenticationError,
    required TResult Function(RegistrationSuccessState value)
        registrationSuccess,
    required TResult Function(RegistrationErrorState value) registrationError,
    required TResult Function(LoggedOutState value) loggedOut,
  }) {
    return authenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitialAuthState value)? initial,
    TResult? Function(AuthStateLoading value)? loading,
    TResult? Function(RegisterStateLoading value)? registerLoading,
    TResult? Function(AuthenticatedState value)? authenticated,
    TResult? Function(Unauthenticated value)? unauthenticated,
    TResult? Function(AuthenticationErrorState value)? authenticationError,
    TResult? Function(RegistrationSuccessState value)? registrationSuccess,
    TResult? Function(RegistrationErrorState value)? registrationError,
    TResult? Function(LoggedOutState value)? loggedOut,
  }) {
    return authenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitialAuthState value)? initial,
    TResult Function(AuthStateLoading value)? loading,
    TResult Function(RegisterStateLoading value)? registerLoading,
    TResult Function(AuthenticatedState value)? authenticated,
    TResult Function(Unauthenticated value)? unauthenticated,
    TResult Function(AuthenticationErrorState value)? authenticationError,
    TResult Function(RegistrationSuccessState value)? registrationSuccess,
    TResult Function(RegistrationErrorState value)? registrationError,
    TResult Function(LoggedOutState value)? loggedOut,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(this);
    }
    return orElse();
  }
}

abstract class AuthenticatedState implements AuthState {
  const factory AuthenticatedState(
      {required final String userId,
      required final String email,
      required final String username}) = _$AuthenticatedStateImpl;

  String get userId;
  String get email;
  String get username;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthenticatedStateImplCopyWith<_$AuthenticatedStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnauthenticatedImplCopyWith<$Res> {
  factory _$$UnauthenticatedImplCopyWith(_$UnauthenticatedImpl value,
          $Res Function(_$UnauthenticatedImpl) then) =
      __$$UnauthenticatedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UnauthenticatedImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$UnauthenticatedImpl>
    implements _$$UnauthenticatedImplCopyWith<$Res> {
  __$$UnauthenticatedImplCopyWithImpl(
      _$UnauthenticatedImpl _value, $Res Function(_$UnauthenticatedImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$UnauthenticatedImpl implements Unauthenticated {
  const _$UnauthenticatedImpl();

  @override
  String toString() {
    return 'AuthState.unauthenticated()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UnauthenticatedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() registerLoading,
    required TResult Function(String userId, String email, String username)
        authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(String errorMessage) authenticationError,
    required TResult Function() registrationSuccess,
    required TResult Function(String errorMessage) registrationError,
    required TResult Function() loggedOut,
  }) {
    return unauthenticated();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? registerLoading,
    TResult? Function(String userId, String email, String username)?
        authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(String errorMessage)? authenticationError,
    TResult? Function()? registrationSuccess,
    TResult? Function(String errorMessage)? registrationError,
    TResult? Function()? loggedOut,
  }) {
    return unauthenticated?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? registerLoading,
    TResult Function(String userId, String email, String username)?
        authenticated,
    TResult Function()? unauthenticated,
    TResult Function(String errorMessage)? authenticationError,
    TResult Function()? registrationSuccess,
    TResult Function(String errorMessage)? registrationError,
    TResult Function()? loggedOut,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitialAuthState value) initial,
    required TResult Function(AuthStateLoading value) loading,
    required TResult Function(RegisterStateLoading value) registerLoading,
    required TResult Function(AuthenticatedState value) authenticated,
    required TResult Function(Unauthenticated value) unauthenticated,
    required TResult Function(AuthenticationErrorState value)
        authenticationError,
    required TResult Function(RegistrationSuccessState value)
        registrationSuccess,
    required TResult Function(RegistrationErrorState value) registrationError,
    required TResult Function(LoggedOutState value) loggedOut,
  }) {
    return unauthenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitialAuthState value)? initial,
    TResult? Function(AuthStateLoading value)? loading,
    TResult? Function(RegisterStateLoading value)? registerLoading,
    TResult? Function(AuthenticatedState value)? authenticated,
    TResult? Function(Unauthenticated value)? unauthenticated,
    TResult? Function(AuthenticationErrorState value)? authenticationError,
    TResult? Function(RegistrationSuccessState value)? registrationSuccess,
    TResult? Function(RegistrationErrorState value)? registrationError,
    TResult? Function(LoggedOutState value)? loggedOut,
  }) {
    return unauthenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitialAuthState value)? initial,
    TResult Function(AuthStateLoading value)? loading,
    TResult Function(RegisterStateLoading value)? registerLoading,
    TResult Function(AuthenticatedState value)? authenticated,
    TResult Function(Unauthenticated value)? unauthenticated,
    TResult Function(AuthenticationErrorState value)? authenticationError,
    TResult Function(RegistrationSuccessState value)? registrationSuccess,
    TResult Function(RegistrationErrorState value)? registrationError,
    TResult Function(LoggedOutState value)? loggedOut,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated(this);
    }
    return orElse();
  }
}

abstract class Unauthenticated implements AuthState {
  const factory Unauthenticated() = _$UnauthenticatedImpl;
}

/// @nodoc
abstract class _$$AuthenticationErrorStateImplCopyWith<$Res> {
  factory _$$AuthenticationErrorStateImplCopyWith(
          _$AuthenticationErrorStateImpl value,
          $Res Function(_$AuthenticationErrorStateImpl) then) =
      __$$AuthenticationErrorStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String errorMessage});
}

/// @nodoc
class __$$AuthenticationErrorStateImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthenticationErrorStateImpl>
    implements _$$AuthenticationErrorStateImplCopyWith<$Res> {
  __$$AuthenticationErrorStateImplCopyWithImpl(
      _$AuthenticationErrorStateImpl _value,
      $Res Function(_$AuthenticationErrorStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorMessage = null,
  }) {
    return _then(_$AuthenticationErrorStateImpl(
      null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AuthenticationErrorStateImpl implements AuthenticationErrorState {
  const _$AuthenticationErrorStateImpl(this.errorMessage);

  @override
  final String errorMessage;

  @override
  String toString() {
    return 'AuthState.authenticationError(errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationErrorStateImpl &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, errorMessage);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthenticationErrorStateImplCopyWith<_$AuthenticationErrorStateImpl>
      get copyWith => __$$AuthenticationErrorStateImplCopyWithImpl<
          _$AuthenticationErrorStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() registerLoading,
    required TResult Function(String userId, String email, String username)
        authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(String errorMessage) authenticationError,
    required TResult Function() registrationSuccess,
    required TResult Function(String errorMessage) registrationError,
    required TResult Function() loggedOut,
  }) {
    return authenticationError(errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? registerLoading,
    TResult? Function(String userId, String email, String username)?
        authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(String errorMessage)? authenticationError,
    TResult? Function()? registrationSuccess,
    TResult? Function(String errorMessage)? registrationError,
    TResult? Function()? loggedOut,
  }) {
    return authenticationError?.call(errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? registerLoading,
    TResult Function(String userId, String email, String username)?
        authenticated,
    TResult Function()? unauthenticated,
    TResult Function(String errorMessage)? authenticationError,
    TResult Function()? registrationSuccess,
    TResult Function(String errorMessage)? registrationError,
    TResult Function()? loggedOut,
    required TResult orElse(),
  }) {
    if (authenticationError != null) {
      return authenticationError(errorMessage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitialAuthState value) initial,
    required TResult Function(AuthStateLoading value) loading,
    required TResult Function(RegisterStateLoading value) registerLoading,
    required TResult Function(AuthenticatedState value) authenticated,
    required TResult Function(Unauthenticated value) unauthenticated,
    required TResult Function(AuthenticationErrorState value)
        authenticationError,
    required TResult Function(RegistrationSuccessState value)
        registrationSuccess,
    required TResult Function(RegistrationErrorState value) registrationError,
    required TResult Function(LoggedOutState value) loggedOut,
  }) {
    return authenticationError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitialAuthState value)? initial,
    TResult? Function(AuthStateLoading value)? loading,
    TResult? Function(RegisterStateLoading value)? registerLoading,
    TResult? Function(AuthenticatedState value)? authenticated,
    TResult? Function(Unauthenticated value)? unauthenticated,
    TResult? Function(AuthenticationErrorState value)? authenticationError,
    TResult? Function(RegistrationSuccessState value)? registrationSuccess,
    TResult? Function(RegistrationErrorState value)? registrationError,
    TResult? Function(LoggedOutState value)? loggedOut,
  }) {
    return authenticationError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitialAuthState value)? initial,
    TResult Function(AuthStateLoading value)? loading,
    TResult Function(RegisterStateLoading value)? registerLoading,
    TResult Function(AuthenticatedState value)? authenticated,
    TResult Function(Unauthenticated value)? unauthenticated,
    TResult Function(AuthenticationErrorState value)? authenticationError,
    TResult Function(RegistrationSuccessState value)? registrationSuccess,
    TResult Function(RegistrationErrorState value)? registrationError,
    TResult Function(LoggedOutState value)? loggedOut,
    required TResult orElse(),
  }) {
    if (authenticationError != null) {
      return authenticationError(this);
    }
    return orElse();
  }
}

abstract class AuthenticationErrorState implements AuthState {
  const factory AuthenticationErrorState(final String errorMessage) =
      _$AuthenticationErrorStateImpl;

  String get errorMessage;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthenticationErrorStateImplCopyWith<_$AuthenticationErrorStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RegistrationSuccessStateImplCopyWith<$Res> {
  factory _$$RegistrationSuccessStateImplCopyWith(
          _$RegistrationSuccessStateImpl value,
          $Res Function(_$RegistrationSuccessStateImpl) then) =
      __$$RegistrationSuccessStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RegistrationSuccessStateImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$RegistrationSuccessStateImpl>
    implements _$$RegistrationSuccessStateImplCopyWith<$Res> {
  __$$RegistrationSuccessStateImplCopyWithImpl(
      _$RegistrationSuccessStateImpl _value,
      $Res Function(_$RegistrationSuccessStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RegistrationSuccessStateImpl implements RegistrationSuccessState {
  const _$RegistrationSuccessStateImpl();

  @override
  String toString() {
    return 'AuthState.registrationSuccess()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegistrationSuccessStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() registerLoading,
    required TResult Function(String userId, String email, String username)
        authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(String errorMessage) authenticationError,
    required TResult Function() registrationSuccess,
    required TResult Function(String errorMessage) registrationError,
    required TResult Function() loggedOut,
  }) {
    return registrationSuccess();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? registerLoading,
    TResult? Function(String userId, String email, String username)?
        authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(String errorMessage)? authenticationError,
    TResult? Function()? registrationSuccess,
    TResult? Function(String errorMessage)? registrationError,
    TResult? Function()? loggedOut,
  }) {
    return registrationSuccess?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? registerLoading,
    TResult Function(String userId, String email, String username)?
        authenticated,
    TResult Function()? unauthenticated,
    TResult Function(String errorMessage)? authenticationError,
    TResult Function()? registrationSuccess,
    TResult Function(String errorMessage)? registrationError,
    TResult Function()? loggedOut,
    required TResult orElse(),
  }) {
    if (registrationSuccess != null) {
      return registrationSuccess();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitialAuthState value) initial,
    required TResult Function(AuthStateLoading value) loading,
    required TResult Function(RegisterStateLoading value) registerLoading,
    required TResult Function(AuthenticatedState value) authenticated,
    required TResult Function(Unauthenticated value) unauthenticated,
    required TResult Function(AuthenticationErrorState value)
        authenticationError,
    required TResult Function(RegistrationSuccessState value)
        registrationSuccess,
    required TResult Function(RegistrationErrorState value) registrationError,
    required TResult Function(LoggedOutState value) loggedOut,
  }) {
    return registrationSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitialAuthState value)? initial,
    TResult? Function(AuthStateLoading value)? loading,
    TResult? Function(RegisterStateLoading value)? registerLoading,
    TResult? Function(AuthenticatedState value)? authenticated,
    TResult? Function(Unauthenticated value)? unauthenticated,
    TResult? Function(AuthenticationErrorState value)? authenticationError,
    TResult? Function(RegistrationSuccessState value)? registrationSuccess,
    TResult? Function(RegistrationErrorState value)? registrationError,
    TResult? Function(LoggedOutState value)? loggedOut,
  }) {
    return registrationSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitialAuthState value)? initial,
    TResult Function(AuthStateLoading value)? loading,
    TResult Function(RegisterStateLoading value)? registerLoading,
    TResult Function(AuthenticatedState value)? authenticated,
    TResult Function(Unauthenticated value)? unauthenticated,
    TResult Function(AuthenticationErrorState value)? authenticationError,
    TResult Function(RegistrationSuccessState value)? registrationSuccess,
    TResult Function(RegistrationErrorState value)? registrationError,
    TResult Function(LoggedOutState value)? loggedOut,
    required TResult orElse(),
  }) {
    if (registrationSuccess != null) {
      return registrationSuccess(this);
    }
    return orElse();
  }
}

abstract class RegistrationSuccessState implements AuthState {
  const factory RegistrationSuccessState() = _$RegistrationSuccessStateImpl;
}

/// @nodoc
abstract class _$$RegistrationErrorStateImplCopyWith<$Res> {
  factory _$$RegistrationErrorStateImplCopyWith(
          _$RegistrationErrorStateImpl value,
          $Res Function(_$RegistrationErrorStateImpl) then) =
      __$$RegistrationErrorStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String errorMessage});
}

/// @nodoc
class __$$RegistrationErrorStateImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$RegistrationErrorStateImpl>
    implements _$$RegistrationErrorStateImplCopyWith<$Res> {
  __$$RegistrationErrorStateImplCopyWithImpl(
      _$RegistrationErrorStateImpl _value,
      $Res Function(_$RegistrationErrorStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorMessage = null,
  }) {
    return _then(_$RegistrationErrorStateImpl(
      null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RegistrationErrorStateImpl implements RegistrationErrorState {
  const _$RegistrationErrorStateImpl(this.errorMessage);

  @override
  final String errorMessage;

  @override
  String toString() {
    return 'AuthState.registrationError(errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegistrationErrorStateImpl &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, errorMessage);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegistrationErrorStateImplCopyWith<_$RegistrationErrorStateImpl>
      get copyWith => __$$RegistrationErrorStateImplCopyWithImpl<
          _$RegistrationErrorStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() registerLoading,
    required TResult Function(String userId, String email, String username)
        authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(String errorMessage) authenticationError,
    required TResult Function() registrationSuccess,
    required TResult Function(String errorMessage) registrationError,
    required TResult Function() loggedOut,
  }) {
    return registrationError(errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? registerLoading,
    TResult? Function(String userId, String email, String username)?
        authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(String errorMessage)? authenticationError,
    TResult? Function()? registrationSuccess,
    TResult? Function(String errorMessage)? registrationError,
    TResult? Function()? loggedOut,
  }) {
    return registrationError?.call(errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? registerLoading,
    TResult Function(String userId, String email, String username)?
        authenticated,
    TResult Function()? unauthenticated,
    TResult Function(String errorMessage)? authenticationError,
    TResult Function()? registrationSuccess,
    TResult Function(String errorMessage)? registrationError,
    TResult Function()? loggedOut,
    required TResult orElse(),
  }) {
    if (registrationError != null) {
      return registrationError(errorMessage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitialAuthState value) initial,
    required TResult Function(AuthStateLoading value) loading,
    required TResult Function(RegisterStateLoading value) registerLoading,
    required TResult Function(AuthenticatedState value) authenticated,
    required TResult Function(Unauthenticated value) unauthenticated,
    required TResult Function(AuthenticationErrorState value)
        authenticationError,
    required TResult Function(RegistrationSuccessState value)
        registrationSuccess,
    required TResult Function(RegistrationErrorState value) registrationError,
    required TResult Function(LoggedOutState value) loggedOut,
  }) {
    return registrationError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitialAuthState value)? initial,
    TResult? Function(AuthStateLoading value)? loading,
    TResult? Function(RegisterStateLoading value)? registerLoading,
    TResult? Function(AuthenticatedState value)? authenticated,
    TResult? Function(Unauthenticated value)? unauthenticated,
    TResult? Function(AuthenticationErrorState value)? authenticationError,
    TResult? Function(RegistrationSuccessState value)? registrationSuccess,
    TResult? Function(RegistrationErrorState value)? registrationError,
    TResult? Function(LoggedOutState value)? loggedOut,
  }) {
    return registrationError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitialAuthState value)? initial,
    TResult Function(AuthStateLoading value)? loading,
    TResult Function(RegisterStateLoading value)? registerLoading,
    TResult Function(AuthenticatedState value)? authenticated,
    TResult Function(Unauthenticated value)? unauthenticated,
    TResult Function(AuthenticationErrorState value)? authenticationError,
    TResult Function(RegistrationSuccessState value)? registrationSuccess,
    TResult Function(RegistrationErrorState value)? registrationError,
    TResult Function(LoggedOutState value)? loggedOut,
    required TResult orElse(),
  }) {
    if (registrationError != null) {
      return registrationError(this);
    }
    return orElse();
  }
}

abstract class RegistrationErrorState implements AuthState {
  const factory RegistrationErrorState(final String errorMessage) =
      _$RegistrationErrorStateImpl;

  String get errorMessage;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegistrationErrorStateImplCopyWith<_$RegistrationErrorStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoggedOutStateImplCopyWith<$Res> {
  factory _$$LoggedOutStateImplCopyWith(_$LoggedOutStateImpl value,
          $Res Function(_$LoggedOutStateImpl) then) =
      __$$LoggedOutStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoggedOutStateImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$LoggedOutStateImpl>
    implements _$$LoggedOutStateImplCopyWith<$Res> {
  __$$LoggedOutStateImplCopyWithImpl(
      _$LoggedOutStateImpl _value, $Res Function(_$LoggedOutStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoggedOutStateImpl implements LoggedOutState {
  const _$LoggedOutStateImpl();

  @override
  String toString() {
    return 'AuthState.loggedOut()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoggedOutStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() registerLoading,
    required TResult Function(String userId, String email, String username)
        authenticated,
    required TResult Function() unauthenticated,
    required TResult Function(String errorMessage) authenticationError,
    required TResult Function() registrationSuccess,
    required TResult Function(String errorMessage) registrationError,
    required TResult Function() loggedOut,
  }) {
    return loggedOut();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? registerLoading,
    TResult? Function(String userId, String email, String username)?
        authenticated,
    TResult? Function()? unauthenticated,
    TResult? Function(String errorMessage)? authenticationError,
    TResult? Function()? registrationSuccess,
    TResult? Function(String errorMessage)? registrationError,
    TResult? Function()? loggedOut,
  }) {
    return loggedOut?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? registerLoading,
    TResult Function(String userId, String email, String username)?
        authenticated,
    TResult Function()? unauthenticated,
    TResult Function(String errorMessage)? authenticationError,
    TResult Function()? registrationSuccess,
    TResult Function(String errorMessage)? registrationError,
    TResult Function()? loggedOut,
    required TResult orElse(),
  }) {
    if (loggedOut != null) {
      return loggedOut();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitialAuthState value) initial,
    required TResult Function(AuthStateLoading value) loading,
    required TResult Function(RegisterStateLoading value) registerLoading,
    required TResult Function(AuthenticatedState value) authenticated,
    required TResult Function(Unauthenticated value) unauthenticated,
    required TResult Function(AuthenticationErrorState value)
        authenticationError,
    required TResult Function(RegistrationSuccessState value)
        registrationSuccess,
    required TResult Function(RegistrationErrorState value) registrationError,
    required TResult Function(LoggedOutState value) loggedOut,
  }) {
    return loggedOut(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(InitialAuthState value)? initial,
    TResult? Function(AuthStateLoading value)? loading,
    TResult? Function(RegisterStateLoading value)? registerLoading,
    TResult? Function(AuthenticatedState value)? authenticated,
    TResult? Function(Unauthenticated value)? unauthenticated,
    TResult? Function(AuthenticationErrorState value)? authenticationError,
    TResult? Function(RegistrationSuccessState value)? registrationSuccess,
    TResult? Function(RegistrationErrorState value)? registrationError,
    TResult? Function(LoggedOutState value)? loggedOut,
  }) {
    return loggedOut?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitialAuthState value)? initial,
    TResult Function(AuthStateLoading value)? loading,
    TResult Function(RegisterStateLoading value)? registerLoading,
    TResult Function(AuthenticatedState value)? authenticated,
    TResult Function(Unauthenticated value)? unauthenticated,
    TResult Function(AuthenticationErrorState value)? authenticationError,
    TResult Function(RegistrationSuccessState value)? registrationSuccess,
    TResult Function(RegistrationErrorState value)? registrationError,
    TResult Function(LoggedOutState value)? loggedOut,
    required TResult orElse(),
  }) {
    if (loggedOut != null) {
      return loggedOut(this);
    }
    return orElse();
  }
}

abstract class LoggedOutState implements AuthState {
  const factory LoggedOutState() = _$LoggedOutStateImpl;
}
