import 'package:real_time_chat_app/data/models/chatRoom.dart';
import 'package:real_time_chat_app/data/models/message.dart';
import 'package:real_time_chat_app/data/models/user.dart';
import 'package:real_time_chat_app/data/providers/chat_provider.dart';

import '../providers/user_provider.dart';

class UserRepository {
  UserProvider _userProvider;
  ChatProvider _chatProvider;

  UserRepository({UserProvider? userProvider, ChatProvider? chatProvider})
      : _userProvider = userProvider ?? UserProvider(),
        _chatProvider = chatProvider ?? ChatProvider();

  Future<List<UserModel>> searchUser(String query) async {
    try {
      print("inside repo try ");
      final response = await _userProvider.searchUser(query);
      print("inside repo try success $response");
      return response;
    } catch (e) {
      print("$e");
      throw Exception("Failed to fetch users: $e");
    }
  }
 Future<UserModel> fetchUser(String userId) async {
    try {
      print("inside repo try ");
      final response = await _userProvider.fetchUser(userId);
      print("inside repo try success $response");
      return response;
    } catch (e) {
      print("$e");
      throw Exception("Failed to fetch users: $e");
    }
  }

  
}
