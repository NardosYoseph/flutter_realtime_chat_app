// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';
@freezed
class User with _$User {
  const factory User({
    required String id,
    required String username,
    required String email,
    required String profilePicture,
  }) = _User;
   factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);


factory User.fromFirestore(DocumentSnapshot doc){
  final data=doc.data() as Map<String, dynamic>;
  return User(id: doc.id, username: data["username"]??'', email: data["email"]??'', profilePicture: data["profilePicture"]??'');
}

ToFirestore(){
  return {
    "name":this.username,
    "email":this.email,
    "profilePicture":this.profilePicture

  };
}
}
