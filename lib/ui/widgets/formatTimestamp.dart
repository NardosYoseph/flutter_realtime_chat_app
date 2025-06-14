import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormatTimestamp extends StatelessWidget {
  final DateTime? timestamp;
  final TextStyle? style;
  
  const FormatTimestamp({
    super.key,
    this.timestamp,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    if (timestamp == null) {
      return SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: style?.color?.withOpacity(0.5),
        ),
      );
    }
    
    return Text(
      DateFormat('hh:mm a').format(timestamp!.toLocal()),
      style: style ?? TextStyle(
        fontSize: 12,
        color: Theme.of(context).textTheme.labelSmall?.color,
      ),
    );
  }
}