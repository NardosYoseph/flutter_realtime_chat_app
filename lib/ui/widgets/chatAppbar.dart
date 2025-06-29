// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/blocs/chat_bloc/chat_bloc.dart';

import '../../util/connectivity_service.dart';

class ChatAppBar extends StatefulWidget implements PreferredSizeWidget {
final String otherUserId; 
  const ChatAppBar({
    Key? key,
    required this.otherUserId,
  }) : super(key: key);
  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  State<ChatAppBar> createState() => _ChatAppBarState();
}

class _ChatAppBarState extends State<ChatAppBar> {
  late final Stream<NetworkStatus> networkStatusStream;
  StreamSubscription<DocumentSnapshot>? _presenceSubscription;
  @override
  void initState() {
    super.initState();
    networkStatusStream = NetworkStatusService().status;
  }

  @override
  void dispose() {
    _presenceSubscription?.cancel();
    super.dispose();
  }

  String _formatLastSeen(DateTime? lastSeen) {
    if (lastSeen == null) return 'long time ago';
    
    final now = DateTime.now();
    final difference = now.difference(lastSeen);
    
    if (difference.inSeconds < 60) return 'last seen just now';
    if (difference.inMinutes < 60) return 'last seen ${difference.inMinutes} min ago';
    if (difference.inHours < 24) return 'last seen ${difference.inHours} hours ago';
    if (difference.inDays < 7) return 'last seen ${difference.inDays} days ago';
    
    return 'last seen on ${lastSeen.day}/${lastSeen.month}/${lastSeen.year}';
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: StreamBuilder<NetworkStatus>(
        stream: networkStatusStream,
        builder: (context, snapshot) {
          final isOffline = snapshot.data == NetworkStatus.offline;

          return BlocBuilder<ChatBloc, ChatState>(
            builder: (context, chatState) {
              if (chatState is ChatLoaded) {
                return StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(widget.otherUserId)
                      .snapshots(),
                  builder: (context, userSnapshot) {
                    if (!userSnapshot.hasData) {
                      return _buildDefaultAppBar(chatState);
                    }
                    
                    final userData = userSnapshot.data!.data() as Map<String, dynamic>;
                    final isOnline = userData['isOnline'] ?? false;
                    final isTyping = userData['isTyping'] ?? false;
                    final lastSeen = userData['lastSeen']?.toDate();
                    
                    return Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () => Navigator.pop(context),
                        ),
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isOnline ? Colors.green : Colors.grey,
                          ),
                          child: CircleAvatar(
                            child: Text(
                              chatState.otherUSerName.isNotEmpty
                                  ? chatState.otherUSerName[0].toUpperCase()
                                  : 'U',
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(chatState.otherUSerName),
                            if (isOffline)
                              Text(
                                "Connecting...",
                                style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                              )
                            else if (isTyping)
                              const Text(
                                "typing...",
                                style: TextStyle(fontSize: 12, color: Colors.green),
                              )
                            else if (isOnline)
                              const Text(
                                "online",
                                style: TextStyle(fontSize: 12, color: Colors.green),
                              )
                            else
                              Text(
                                _formatLastSeen(lastSeen),
                                style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                              ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              }
              return _buildDefaultAppBar();
            },
          );
        },
      ),
    );
  }

  Widget _buildDefaultAppBar([ChatLoaded? state]) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        const Text("PingMe"),
      ],
    );
  }
}