import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider {
  FirebaseAuth _firebaseAuth;
  AuthProvider({FirebaseAuth? firebase_auth})
  :_firebaseAuth=firebase_auth??FirebaseAuth.instance;

  Future SignUp(String email,String password,String name) async{
    try{
      final userCredential= await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password,);
await userCredential.user?.updateDisplayName(name);
    }catch(e){
      throw Exception('failed to signup $e');
    }

  }
Future<User?> login(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      return userCredential.user;
    } catch (e) {
      throw Exception('Failed to log in: $e');
    }
  }
}