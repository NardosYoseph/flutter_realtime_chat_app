import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/chat_bloc/chat_bloc.dart';

class ChatInputTextField extends StatefulWidget {
  ChatInputTextField({super.key,required this.controller,required this.userId,required this.receiverId});
  final TextEditingController controller;
  final String userId;
  final String receiverId;

  @override
  State<ChatInputTextField> createState() => _ChatInputTextFieldState();
}

class _ChatInputTextFieldState extends State<ChatInputTextField> {
  Timer? _typingTimer;
  bool _isTyping = false;
String _previousText = '';
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_handleTextChange);
  }
    @override
  void dispose() {
    _cancelTimer();
    widget.controller.removeListener(_handleTextChange);
    // Ensure we clear typing status when widget is disposed
    if (_isTyping) {
      _updateTypingStatus(false);
    }
    super.dispose();
  }

  void _handleTextChange() {
    final currentText = widget.controller.text;
    
    // Only update status if text actually changed (not just cursor movement)
    if (currentText != _previousText) {
      _previousText = currentText;
      final isTyping = currentText.isNotEmpty;
      
      // Always reset timer on any change
      _cancelTimer();
      
      // Update status if changed
      if (isTyping != _isTyping) {
        _updateTypingStatus(isTyping);
      }
      
      // Set timer to stop typing after inactivity
      if (isTyping) {
        _typingTimer = Timer(const Duration(seconds: 3), () {
          if (_isTyping) {
            _updateTypingStatus(false);
          }
        });
      }
    }
  }

    void _updateTypingStatus(bool isTyping) {
    _isTyping = isTyping;
    context.read<ChatBloc>().add(UserTyping(isTyping));
  }


  void _cancelTimer() {
    _typingTimer?.cancel();
    _typingTimer = null;
  }

  @override
  Widget build(BuildContext context) {
  final chatBloc = context.read<ChatBloc>();
final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: widget.controller,
              onChanged: (value) {
                if(value.isEmpty && _isTyping) {
                  _updateTypingStatus(false);
                } else if(value.isNotEmpty && !_isTyping) {
                   chatBloc.add(UserTyping(true));}
              },
              style: theme.textTheme.bodyLarge,
              decoration:  InputDecoration(
                hintText: "Type a message...",
                 hintStyle: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.5),
                ),
                filled: true,
                 fillColor: theme.colorScheme.surfaceVariant,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
              minLines: 1,
              maxLines: 3,
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.colorScheme.primary,
            ),
            child: IconButton(
            icon: Icon(Icons.send,color: theme.colorScheme.onPrimary),
            onPressed: () {
              final message = widget.controller.text.trim();
              if (message.isNotEmpty) {
                print("input receiverId: ${widget.receiverId}");
                print("input senderid: ${widget.userId}");
                print("send button tapped");
                 if (_isTyping) {
                    _updateTypingStatus(false);
                  }
                chatBloc.add(SendMessageEvent(widget.userId,widget.receiverId, message));
                widget.controller.clear();
              }
            },
          ),)
        ],
      ),
    );
  }
}