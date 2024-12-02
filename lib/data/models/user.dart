// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String id;
  String name;
  String email;
  String profilePicture;
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.profilePicture,
  });

factory User.fromFirestore(DocumentSnapshot doc){
  final data=doc.data() as Map<String, dynamic>;
  return User(id: doc.id, name: data["name"]??'', email: data["email"]??'', profilePicture: data["profilePicture"]??'');
}

ToFirestore(){
  return {
    "name":this.name,
    "email":this.email,
    "profilePicture":this.profilePicture

  };
}
}
