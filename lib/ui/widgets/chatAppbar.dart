import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/blocs/chat_bloc/chat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/blocs/chat_bloc/chat_bloc.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      // backgroundColor: Colors.transparent, // Make background transparent for gradient
      elevation: 4, // Subtle shadow
      flexibleSpace: Container(
        decoration: BoxDecoration(
          // gradient: LinearGradient(
          //   colors: [
          //                      Colors.purple, // Soft blue
          //               Colors.purple, // Soft blue

          //   ],
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          // ),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black.withOpacity(0.2),
          //     blurRadius: 10,
          //     offset: const Offset(0, 4),
          //   ),
          // ],
        ),
      ),
      title: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is ChatLoaded) {
            return Row(
              children: [
                // CircleAvatar with Gradient Border
                Container(
                  padding: const EdgeInsets.all(2), // Border width
                  decoration: BoxDecoration(
                    
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
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
                  style:  TextStyle(
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
          return Text(
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
      actions: [
        IconButton(
          icon: const Icon(Icons.search,),
          onPressed: () {
            // Add search functionality
          },
        ),
        IconButton(
          icon: const Icon(Icons.more_vert,),
          onPressed: () {
            // Add more options functionality
          },
        ),
      ],
    );
  }
}