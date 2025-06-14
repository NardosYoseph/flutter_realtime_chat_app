import 'package:flutter/material.dart';
import 'package:real_time_chat_app/ui/widgets/formatTimestamp.dart';
import '../../data/models/message.dart';
import '../theme/appTheme.dart';

class MessageBuble extends StatefulWidget {
  final Message message;
  final bool isSentByMe;

  const MessageBuble({
    super.key,
    required this.message,
    required this.isSentByMe,
  });

  @override
  State<MessageBuble> createState() => _MessageBubleState();
}

class _MessageBubleState extends State<MessageBuble> {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        setState(() => _isVisible = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isSent = widget.isSentByMe;

    return AnimatedOpacity(
      opacity: _isVisible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
      child: Align(
        alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75,
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 16,
            ),
            decoration: isSent
                ? AppTheme.sentMessageDecoration(context)
                : AppTheme.receivedMessageDecoration(context),
            child: Column(
              crossAxisAlignment:
                  isSent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  widget.message.content,
                  style: isSent
                      ? AppTheme.sentMessageTextStyle(context)
                      : AppTheme.receivedMessageTextStyle(context),
                ),
                const SizedBox(height: 4),
                FormatTimestamp(
                  timestamp: widget.message.timestamp,
                  style: AppTheme.messageTimeStyle(context, widget.isSentByMe),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
