// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  String get id => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get profilePicture => throw _privateConstructorUsedError;
  String? get fcmToken => throw _privateConstructorUsedError;
  bool get isOnline => throw _privateConstructorUsedError;
  bool get isTyping => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  DateTime? get lastSeen => throw _privateConstructorUsedError;

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call(
      {String id,
      String username,
      String email,
      String profilePicture,
      String? fcmToken,
      bool isOnline,
      bool isTyping,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      DateTime? lastSeen});
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? email = null,
    Object? profilePicture = null,
    Object? fcmToken = freezed,
    Object? isOnline = null,
    Object? isTyping = null,
    Object? lastSeen = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      profilePicture: null == profilePicture
          ? _value.profilePicture
          : profilePicture // ignore: cast_nullable_to_non_nullable
              as String,
      fcmToken: freezed == fcmToken
          ? _value.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String?,
      isOnline: null == isOnline
          ? _value.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      isTyping: null == isTyping
          ? _value.isTyping
          : isTyping // ignore: cast_nullable_to_non_nullable
              as bool,
      lastSeen: freezed == lastSeen
          ? _value.lastSeen
          : lastSeen // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
          _$UserModelImpl value, $Res Function(_$UserModelImpl) then) =
      __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String username,
      String email,
      String profilePicture,
      String? fcmToken,
      bool isOnline,
      bool isTyping,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      DateTime? lastSeen});
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
      _$UserModelImpl _value, $Res Function(_$UserModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? email = null,
    Object? profilePicture = null,
    Object? fcmToken = freezed,
    Object? isOnline = null,
    Object? isTyping = null,
    Object? lastSeen = freezed,
  }) {
    return _then(_$UserModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      profilePicture: null == profilePicture
          ? _value.profilePicture
          : profilePicture // ignore: cast_nullable_to_non_nullable
              as String,
      fcmToken: freezed == fcmToken
          ? _value.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String?,
      isOnline: null == isOnline
          ? _value.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      isTyping: null == isTyping
          ? _value.isTyping
          : isTyping // ignore: cast_nullable_to_non_nullable
              as bool,
      lastSeen: freezed == lastSeen
          ? _value.lastSeen
          : lastSeen // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserModelImpl implements _UserModel {
  const _$UserModelImpl(
      {required this.id,
      required this.username,
      required this.email,
      required this.profilePicture,
      this.fcmToken,
      this.isOnline = false,
      this.isTyping = false,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      this.lastSeen});

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  @override
  final String id;
  @override
  final String username;
  @override
  final String email;
  @override
  final String profilePicture;
  @override
  final String? fcmToken;
  @override
  @JsonKey()
  final bool isOnline;
  @override
  @JsonKey()
  final bool isTyping;
  @override
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  final DateTime? lastSeen;

  @override
  String toString() {
    return 'UserModel(id: $id, username: $username, email: $email, profilePicture: $profilePicture, fcmToken: $fcmToken, isOnline: $isOnline, isTyping: $isTyping, lastSeen: $lastSeen)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.profilePicture, profilePicture) ||
                other.profilePicture == profilePicture) &&
            (identical(other.fcmToken, fcmToken) ||
                other.fcmToken == fcmToken) &&
            (identical(other.isOnline, isOnline) ||
                other.isOnline == isOnline) &&
            (identical(other.isTyping, isTyping) ||
                other.isTyping == isTyping) &&
            (identical(other.lastSeen, lastSeen) ||
                other.lastSeen == lastSeen));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, username, email,
      profilePicture, fcmToken, isOnline, isTyping, lastSeen);

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelImplToJson(
      this,
    );
  }
  
  @override
  Map<String, dynamic> toFirestore() {
    // TODO: implement toFirestore
    throw UnimplementedError();
  }
}

abstract class _UserModel implements UserModel {
  const factory _UserModel(
      {required final String id,
      required final String username,
      required final String email,
      required final String profilePicture,
      final String? fcmToken,
      final bool isOnline,
      final bool isTyping,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      final DateTime? lastSeen}) = _$UserModelImpl;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  @override
  String get id;
  @override
  String get username;
  @override
  String get email;
  @override
  String get profilePicture;
  @override
  String? get fcmToken;
  @override
  bool get isOnline;
  @override
  bool get isTyping;
  @override
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  DateTime? get lastSeen;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
