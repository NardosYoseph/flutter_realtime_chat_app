import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/blocs/chat_bloc/chat_bloc.dart';
import 'package:real_time_chat_app/data/models/chatRoom.dart';
import 'package:real_time_chat_app/ui/screens/chat_screen.dart';
import 'package:real_time_chat_app/ui/widgets/customAppbar.dart';
import 'package:real_time_chat_app/ui/widgets/customDrawer.dart';
import 'package:real_time_chat_app/ui/widgets/topFriendsList.dart';

import '../../blocs/auth_bloc/auth_bloc.dart';
import '../widgets/allChatsHeader.dart';
import '../widgets/chatRoomList.dart';
import '../widgets/topFriendsSection.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
final List<Map<String, String>> demoUsers = [
    {'name': 'Alice', 'avatarUrl': 'https://via.placeholder.com/150'},
    {'name': 'Bob', 'avatarUrl': 'https://via.placeholder.com/150'},
    {'name': 'Charlie', 'avatarUrl': 'https://via.placeholder.com/150'},
    {'name': 'Daisy', 'avatarUrl': 'https://via.placeholder.com/150'},
    {'name': 'Eve', 'avatarUrl': 'https://via.placeholder.com/150'},
    {'name': 'Eve', 'avatarUrl': 'https://via.placeholder.com/150'},
    {'name': 'Eve', 'avatarUrl': 'https://via.placeholder.com/150'},
  ];



 @override
  void initState() {
    super.initState();
_fetchChatRooms();
  }
 void _fetchChatRooms() {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthenticatedState) {
      final userId = authState.userId;
      context.read<ChatBloc>().add(FetchChatRoomsEvent(userId));
    }
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      drawer: CustomDrawer(),
      appBar: CustomAppBar(),
      body: Column(
        children: [
          TopFriendsSection(),
          AllChatsHeader(),
          ChatRoomsSection(),
        ],
      ),
    );
  }
}
