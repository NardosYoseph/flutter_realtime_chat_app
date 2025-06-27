// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String username,
    required String email,
    required String profilePicture,
    String? fcmToken,
    @Default(false) bool isOnline,
    @Default(false) bool isTyping,
    @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
    DateTime? lastSeen,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: doc.id,
      username: data["username"] ?? '',
      email: data["email"] ?? '',
      profilePicture: data["profilePicture"] ?? '',
      fcmToken: data["fcmToken"],
      isOnline: data["isOnline"] ?? false,
      isTyping: data["isTyping"] ?? false,
      lastSeen: data["lastSeen"]?.toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "username": username,
      "email": email,
      "profilePicture": profilePicture,
      if (fcmToken != null) "fcmToken": fcmToken,
      "isOnline": isOnline,
      "isTyping": isTyping,
      if (lastSeen != null) "lastSeen": lastSeen,
    };
  }
}

DateTime? _timestampFromJson(Timestamp? timestamp) => timestamp?.toDate();
Timestamp? _timestampToJson(DateTime? date) => 
    date != null ? Timestamp.fromDate(date) : null;