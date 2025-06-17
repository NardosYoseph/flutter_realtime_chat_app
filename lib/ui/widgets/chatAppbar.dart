import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/blocs/chat_bloc/chat_bloc.dart';
import '../../util/connectivity_service.dart';

class ChatAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  State<ChatAppBar> createState() => _ChatAppBarState();
}

class _ChatAppBarState extends State<ChatAppBar> {
  late final Stream<NetworkStatus> networkStatusStream;

  @override
  void initState() {
    super.initState();
    networkStatusStream = NetworkStatusService().status;
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
            builder: (context, state) {
              return Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  if (state is ChatLoaded && !isOffline) ...[
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: CircleAvatar(
                        child: Text(
                          state.otherUSerName.isNotEmpty
                              ? state.otherUSerName[0].toUpperCase()
                              : 'U',
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(state.otherUSerName),
                  ] else if (state is ChatLoaded && isOffline) ...[
                    Container(
                                          padding: const EdgeInsets.all(2),
                                          decoration: const BoxDecoration(shape: BoxShape.circle),
                                          child: CircleAvatar(
                                            child: Text(
                    state.otherUSerName.isNotEmpty
                        ? state.otherUSerName[0].toUpperCase()
                        : 'U',
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                             Column(
                                               children: [
                                                 Text(state.otherUSerName),
                                            Text("Connecting...",style: TextStyle(fontSize: 12,color: Colors.grey[400]),),

                                               ],
                                             ),
                  ] else ...[
                    const Text("PingMe"),
                  ],
                ],
              );
            },
          );
        },
      ),
    );
  }
}
