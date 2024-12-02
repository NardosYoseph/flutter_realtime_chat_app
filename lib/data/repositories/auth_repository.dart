import '../providers/auth_provider.dart';
class AuthRepository {
 final AuthProvider _authProvider;
  AuthRepository({AuthProvider? authProvider}):
  _authProvider=authProvider ?? AuthProvider();

  Future<void> login(String email, String password)async{
    try{
      final response=await _authProvider.login(email, password);
    }
    catch(e){
      throw Exception('failed to login $e');
    }
  }
  Future<void> register(String email,String password,String name)async{
    try{
final response=await _authProvider.SignUp(email, password, name);
    }catch(e){
      throw Exception('error registoring user $e');
    }
  }
  
}