import 'package:flutter/material.dart';
import 'package:real_time_chat_app/ui/widgets/topFriendsList.dart';

class TopFriendsSection extends StatelessWidget {
  const TopFriendsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const demoUsers = [
      {'name': 'Alice', 'avatarUrl': 'https://via.placeholder.com/150'},
      {'name': 'Bob', 'avatarUrl': 'https://via.placeholder.com/150'},
      {'name': 'Charlie', 'avatarUrl': 'https://via.placeholder.com/150'},
      {'name': 'Daisy', 'avatarUrl': 'https://via.placeholder.com/150'},
      {'name': 'Eve', 'avatarUrl': 'https://via.placeholder.com/150'},
      {'name': 'Eve', 'avatarUrl': 'https://via.placeholder.com/150'},
      {'name': 'Eve', 'avatarUrl': 'https://via.placeholder.com/150'},
    ];
    return TopFriendsList(users: demoUsers);
  }
}
