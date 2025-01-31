// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormatTimestamp extends StatelessWidget {

DateTime? timestamp;
  FormatTimestamp({
    Key? key,
    this.timestamp,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
  
  if (timestamp == null) {
    return const SizedBox(
      width: 16, // Adjust size as needed
      height: 16, // Adjust size as needed
      child: CircularProgressIndicator(
        strokeWidth: 2, // Adjust stroke width as needed
      ),
    );
  }
  return Text(
    DateFormat('hh:mm a').format(timestamp!.toLocal()),
    style:  TextStyle(
      fontSize: 12, 
    //  color: Colors.white.withOpacity(0.7),
              
    ),
  );

  }
}
