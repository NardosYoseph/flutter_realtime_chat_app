// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String id;
  String username;
  String email;
  String profilePicture;
  User({
    required this.id,
    required this.username,
    required this.email,
    required this.profilePicture,
  });

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
