import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:real_time_chat_app/data/models/user.dart';

class UserProvider {
 final FirebaseFirestore _firebaseFirestore=FirebaseFirestore.instance;
 Future<List<User>> searchUser(String query)async{
  try{
      print("inside provider try ");

    final snapShoot=await _firebaseFirestore.collection("users") .where('username', isGreaterThanOrEqualTo: query)
          .where('username', isLessThanOrEqualTo: "$query\uf8ff").get();
      print("inside provider try success $snapShoot");

  return snapShoot.docs.map((doc)=>User.fromFirestore(doc)).toList();
  }catch(e){
    throw Exception('error sarching user');
  }

 }
 Future<User> fetchUser(String userId) async {
 try {
    final docSnapshot = await _firebaseFirestore.collection('users').doc(userId).get();

    if (docSnapshot.exists) {
      return User.fromFirestore(docSnapshot);
    } else {
      throw Exception('User not found');
    }
  } catch (e) {
    throw Exception('Error fetching user: $e');
  }
}

}