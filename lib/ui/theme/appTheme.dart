import 'package:flutter/material.dart';
import 'appColors.dart';
import 'package:flutter/material.dart';
import 'appColors.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: AppColors.lightPrimary,
    // colorScheme: const ColorScheme.light().copyWith(secondary: AppColors.lightAccent),
     textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black87),
      labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
    appBarTheme:  const AppBarTheme(
      backgroundColor: Colors.white,
      // color: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    drawerTheme: const DrawerThemeData(),
    
     elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.pink, // Apply pink to buttons
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ),
   inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.pink[50], // Light pink background for inputs
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      labelStyle: const TextStyle(color: Colors.pinkAccent),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBackground,
    primaryColor: AppColors.darkPrimary,
    // colorScheme: const ColorScheme.dark().copyWith(secondary: AppColors.darkAccent),
     textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white70),
      labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
    appBarTheme: const AppBarTheme(
      color: AppColors.darkPrimary,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
  drawerTheme: const DrawerThemeData(),
   elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.pinkAccent,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ),
     inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.pink[900], // Dark pink input background
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      labelStyle: const TextStyle(color: Colors.pinkAccent),
    ),
  );



  // Message Bubble Colors
  static Color getSentMessageColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? AppColors.sentMessageLight
        : AppColors.sentMessageDark;
  }

  static Color getReceivedMessageColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? AppColors.receivedMessageLight
        : AppColors.receivedMessageDark;
  }

  // Message Text Colors
  static Color getSentMessageTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? Colors.white // White text for sent messages in light mode
        : Colors.black; // Black text for sent messages in dark mode
  }

  static Color getReceivedMessageTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? AppColors.lightText // Dark blue-gray text for received messages in light mode
        : AppColors.darkText; // Light beige text for received messages in dark mode
  }
}