// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      profilePicture: json['profilePicture'] as String,
      fcmToken: json['fcmToken'] as String?,
      isOnline: json['isOnline'] as bool? ?? false,
      isTyping: json['isTyping'] as bool? ?? false,
      lastSeen: _timestampFromJson(json['lastSeen'] as Timestamp?),
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'profilePicture': instance.profilePicture,
      'fcmToken': instance.fcmToken,
      'isOnline': instance.isOnline,
      'isTyping': instance.isTyping,
      'lastSeen': _timestampToJson(instance.lastSeen),
    };
