import 'package:flutter/material.dart';
import 'package:real_time_chat_app/ui/widgets/formatTimestamp.dart';
import '../../data/models/message.dart';
import '../theme/appTheme.dart';
// import 'appThemes.dart'; // Import AppThemes

class MessageBuble extends StatefulWidget {
  final Message message;
  final bool isSentByMe;

  const MessageBuble({
    Key? key,
    required this.message,
    required this.isSentByMe,
  }) : super(key: key);

  @override
  _MessageBubleState createState() => _MessageBubleState();
}

class _MessageBubleState extends State<MessageBuble> {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        _isVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _isVisible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 500),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: widget.isSentByMe
              ? AppThemes.getSentMessageColor(context) // Sent message color
              : AppThemes.getReceivedMessageColor(context), // Received message color
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(widget.isSentByMe ? 12 : 0),
            topRight: Radius.circular(widget.isSentByMe ? 0 : 12),
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
          border: Border.all(
            width: 1,
            color: widget.isSentByMe
                ? AppThemes.getSentMessageColor(context) // Sent message border color
                : AppThemes.getReceivedMessageColor(context), // Received message border color
          ),
        ),
        child: Column(
          crossAxisAlignment: widget.isSentByMe
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              widget.message.content,
              style: TextStyle(
                color: widget.isSentByMe
                    ? AppThemes.getSentMessageTextColor(context) // Sent message text color
                    : AppThemes.getReceivedMessageTextColor(context),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            FormatTimestamp(
              timestamp: widget.message.timestamp,
            ),
          ],
        ),
      ),
    );
  }
}