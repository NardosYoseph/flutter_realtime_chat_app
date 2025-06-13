import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/blocs/chat_bloc/chat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/blocs/chat_bloc/chat_bloc.dart';

import '../theme/appColors.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      elevation: 4, // Subtle shadow
      flexibleSpace: Container(
        
      ),
      title: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is ChatLoaded) {
            return Row(
              children: [
                // CircleAvatar with Gradient Border
                Container(
                  padding: const EdgeInsets.all(2), // Border width
                  decoration: const BoxDecoration(
                    
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                     backgroundColor: AppColors.lightPrimary,
                    child: Text(
                      state.otherUSerName.isNotEmpty
                          ? state.otherUSerName[0].toUpperCase()
                          : '?',
                      style: const TextStyle( // Dark blue-gray
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // User Name with Fancy Text
                Text(
                  state.otherUSerName,
                  style:  const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    // shadows: [
                    //   Shadow(
                    //     blurRadius: 4,
                    //     offset: Offset(1, 1),
                    //   ),
                    // ],
                  ),
                ),
              ],
            );
          }
          return const Text(
            "Chat",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              // shadows: [
              //   Shadow(
              //     color: Colors.black.withOpacity(0.3),
              //     blurRadius: 4,
              //     offset: Offset(1, 1),
              //   ),
              // ],
            ),
          );
        },
      ),
      // Add Icons or Actions
      // actions: [
      //   IconButton(
      //     icon: const Icon(Icons.search,),
      //     onPressed: () {
      //       // Add search functionality
      //     },
      //   ),
      //   IconButton(
      //     icon: const Icon(Icons.more_vert,),
      //     onPressed: () {
      //       // Add more options functionality
      //     },
      //   ),
      // ],
    );
  }
}