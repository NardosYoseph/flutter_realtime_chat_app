import 'package:flutter/material.dart';

class AppColors {
  // Seed color that will generate the whole palette
  static const Color seedColor = Color(0xFF6750A4); // Purple base

  // Generated colors
  static late final ColorScheme lightColorScheme;
  static late final ColorScheme darkColorScheme;

  // No need for hardcoded message colors - we'll derive them from the scheme

  // Text colors optimized for readability
  static const Color sentMessageTextLight = Colors.white;
  static const Color receivedMessageTextLight = Colors.black; // Dark blue-gray
  static const Color sentMessageTextDark = Colors.white;
  static const Color receivedMessageTextDark = Color(0xFFECEFF1); // Light blue-gray

  // Status colors
  static const Color successColor = Color(0xFF4CAF50);
  static const Color errorColor = Color(0xFFF44336);
  static const Color warningColor = Color(0xFFFFC107);
  static const Color infoColor = Color(0xFF2196F3);
}