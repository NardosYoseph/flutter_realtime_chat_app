import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/blocs/user_bloc/user_bloc.dart';
import 'package:real_time_chat_app/ui/widgets/customAppbar.dart';
import 'package:real_time_chat_app/ui/widgets/customDrawer.dart';

import '../../blocs/auth_bloc/auth_bloc.dart';

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
                fillColor: Colors.white,
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
                    return ListView.builder(
                      itemCount: state.users.length,
                      itemBuilder: (context, index) {
                        final user = state.users[index];
                        // Return the widget here
                        return GestureDetector(
                          onTap: (){
                            final authState = context.read<AuthBloc>().state;
    if (authState is AuthenticatedState) {
      String currentUserId = authState.userId;
                         context.read<UserBloc>().add(SelectUserEvent(currentUserId, user.id));
                         
                             }   },
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
                                  style: const TextStyle(color: Colors.white70),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text("Start searching for users by typing a username."),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
