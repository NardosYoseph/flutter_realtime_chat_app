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
     final theme = Theme.of(context); 
    return AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        
      ),
      titleSpacing: 10,

      title: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is ChatLoaded) {
            return Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(2), // Border width
                  decoration: const BoxDecoration(
                    
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    child: Text(
                      state.otherUSerName.isNotEmpty
                          ? state.otherUSerName[0].toUpperCase()
                          : '?',
          //             style: theme.textTheme.titleLarge?.copyWith(
          //   fontWeight: FontWeight.bold,
          //   color: theme.colorScheme.primary,
          // ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  state.otherUSerName,
          //      style: theme.textTheme.titleLarge?.copyWith(
          //   fontWeight: FontWeight.bold,
          //   color: theme.colorScheme.onSecondary,
          // ),
                ),
              ],
            );
          }
          return  Text(
            "PingMe",
          //  style: theme.textTheme.titleLarge?.copyWith(
          //   fontWeight: FontWeight.bold,
          //   color: theme.colorScheme.onSecondary,
          // ),
          );
        },
      ),
    );
  }
}