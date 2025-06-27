import 'package:firebase_auth/firebase_auth.dart';
import 'package:real_time_chat_app/data/models/user.dart';
import '../providers/auth_provider.dart';
import 'user_repository.dart';

class AuthRepository {
  final AppAuthProvider _authProvider;
  final UserRepository _userRepository;

  AuthRepository({
    AppAuthProvider? authProvider,
    UserRepository? userRepository,
  })  : _authProvider = authProvider ?? AppAuthProvider(),
        _userRepository = userRepository ?? UserRepository();

  Future<UserModel> login(String email, String password) async {
    try {
      final userCredential = await _authProvider.login(email, password);
      print(userCredential);

      final uid = userCredential.user?.uid;

      if (uid == null) {
        throw Exception('User ID not found');
      }

      // Fetch user details using UserRepository
      return await _userRepository.fetchUser(uid);
    } catch (e) {
      throw Exception('Failed to log in: $e');
    }
  }

  Future<UserModel> register(String email, String password, String name) async {
    print("in repo class");

    try {
      final userCredential = await _authProvider.SignUp(email, password, name);
        final uid = userCredential.user?.uid;

     if (uid == null) {
        throw Exception('User ID not found');
      }
      print("in repo class try success");

      return await _userRepository.fetchUser(uid);
    } catch (e) {
      throw Exception('Error registering user: $e');
    }
  }

  Future<void> logout() async {
    try {
       await _authProvider.logout();
    } catch (e) {
      throw Exception('Failed to log in: $e');
    }
  }
  Future<UserCredential> signInWithGoogle() async {
    try {
      final userCredential = await _authProvider.signInWithGoogle();
      return userCredential;
    } catch (e) {
      throw Exception('Google sign-in failed: ${e.toString()}');
    }
  }

}
