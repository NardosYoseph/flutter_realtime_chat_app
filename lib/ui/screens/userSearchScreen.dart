import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/blocs/auth_bloc/auth_state.dart';
import 'package:real_time_chat_app/blocs/user_bloc/user_bloc.dart';
import 'package:real_time_chat_app/ui/screens/chat_screen.dart';
import 'package:real_time_chat_app/ui/widgets/customAppbar.dart';
import 'package:real_time_chat_app/ui/widgets/customDrawer.dart';

import '../../blocs/auth_bloc/auth_bloc.dart';
import '../../blocs/chat_bloc/chat_bloc.dart';

class SearchUserScreen extends StatelessWidget {
  const SearchUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                // fillColor: Colors.white,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
              controller: usernameController,
              onChanged: (value) {
                context.read<UserBloc>().add(UserSearchEvent(usernameController.text.trim()));
              },
            ),
            SizedBox(height: 20,),
            Expanded(
              child: BlocConsumer<UserBloc, UserState>(
                listener: (context, state) {
                  if (state is UsersError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is UsersLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is UsersLoaded) {
                            final authState = context.read<AuthBloc>().state;

                                          if (authState is AuthenticatedState) {
      String currentUserId = authState.userId;
       final filteredUsers = state.users.where((user) => user.id != currentUserId).toList();

                    return ListView.builder(
                      itemCount: filteredUsers.length,
                      itemBuilder: (context, index) {

  
                        final user = filteredUsers[index];
                        // Return the widget here
                        return GestureDetector(
                          onTap: (){
                           print("User clicked: ${user.username}");
      String currentUserId = authState.userId;
      print("Authenticated User: $currentUserId");
                         context.read<UserBloc>().add(SelectUserEvent(currentUserId, user.id));
                         context.read<ChatBloc>().add(SelectChatRoomFromSearchEvent(currentUserId, user.id));
                            Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChatScreen()),
                    );
                               },
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                
                                Text(
                                  "@${user.username}",
                                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  user.email,
                                  style: const TextStyle(color: Colors.black),
                                ),
                                SizedBox(height: 10,)
                              ],
                            ),
                          ),
                        );
                        }
                    
                    );
                    
                    }
                  } else {
                    return const Center(
                      child: Text("Find friends by typing a username."),
                    );
                  }
                  return SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
