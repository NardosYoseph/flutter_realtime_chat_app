import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:real_time_chat_app/data/models/user.dart';

import '../providers/auth_provider.dart';
class AuthRepository {
 final AuthProvider _authProvider;
  AuthRepository({AuthProvider? authProvider}):
  _authProvider=authProvider ?? AuthProvider();

Future<User> login(String email, String password) async {
  try {
    // Authenticate the user
    final userCredential = await _authProvider.login(email, password);
print(userCredential);
    // Get the user ID from the UserCredential
    final uid = userCredential.user?.uid;

    if (uid == null) {
      throw Exception('User ID not found');
    }

    // Retrieve user data from Firestore
    final userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();

    if (!userDoc.exists) {
      throw Exception('User profile not found in Firestore');
    }

    // Map the Firestore document to your User model
    return User.fromFirestore(userDoc);
  } catch (e) {
    throw Exception('Failed to log in: $e');
  }
}

  Future<void> register(String email,String password,String name)async{
print("in repo class");

    try{
final response=await _authProvider.SignUp(email, password, name);
print("in repo class try success");
    }catch(e){
      throw Exception('error registoring user $e');
    }
  }
  
}