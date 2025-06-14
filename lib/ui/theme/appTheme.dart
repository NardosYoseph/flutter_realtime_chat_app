import 'package:flutter/material.dart';
import 'appColors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: AppColors.lightColorScheme,
      appBarTheme: AppBarTheme(
        // centerTitle: true,
               elevation: 0,
        // scrolledUnderElevation: 2,
        backgroundColor: AppColors.lightColorScheme.primary, // Surface color
        foregroundColor: AppColors.lightColorScheme.onPrimary, // OnSurface text color
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.lightColorScheme.onPrimary, // Ensures text contrast
        ),
        iconTheme: IconThemeData(
          color: AppColors.lightColorScheme.onPrimary, // Icons match text
        ),
       ),
      cardTheme: CardTheme(
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: AppColors.lightColorScheme.onPrimary,
          backgroundColor: AppColors.lightColorScheme.primary,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.lightColorScheme.primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.lightColorScheme.primary,
          side: BorderSide(color: AppColors.lightColorScheme.outline),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.lightColorScheme.outline),
        ),
        filled: true,
        fillColor: AppColors.lightColorScheme.surfaceContainerHighest,
      ),
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        side: BorderSide.none,
        labelPadding: const EdgeInsets.symmetric(horizontal: 12),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      
    ),
    
    );

  }

  static ThemeData get darkTheme {
  return ThemeData(
    useMaterial3: true,
    colorScheme: AppColors.darkColorScheme,
    
    // Scaffold background (dark gray instead of pure black)
    scaffoldBackgroundColor: Colors.grey[900], // Dark gray background for better contrast
    
    // App Bar
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.grey[900],
      scrolledUnderElevation: 2,
       titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.lightColorScheme.onPrimary, // Ensures text contrast
        ),
        iconTheme: IconThemeData(
          color: AppColors.lightColorScheme.onPrimary, // Icons match text
        ),
    ),
    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkColorScheme.primary, // Primary color for buttons
        foregroundColor: AppColors.darkColorScheme.onPrimary, // Text/icon color
        elevation: 2,
        shadowColor: Colors.black,
        minimumSize: const Size(double.infinity, 48), // Full width, 48px height
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Matches your card radius
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    ),
    // Cards
    cardTheme: CardTheme(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Colors.grey[900],
    ),

    // Input Fields
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: AppColors.darkColorScheme.outline.withOpacity(0.5),
        ),
      ),
      filled: true,
      fillColor: AppColors.darkColorScheme.surfaceVariant,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),

    // Text Theme
    textTheme: TextTheme(
      bodyMedium: TextStyle(
        color: AppColors.darkColorScheme.onSurface.withOpacity(0.9),
      ),
      titleMedium: TextStyle(
        color: AppColors.darkColorScheme.onSurface.withOpacity(0.8),
      ),
      labelSmall: TextStyle(
        color: AppColors.darkColorScheme.onSurface.withOpacity(0.6),
      ),
    ),
    // Custom component overrides
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.darkColorScheme.surfaceContainerHigh,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      side: BorderSide.none,
      labelPadding: const EdgeInsets.symmetric(horizontal: 12),
    ),
  );
}
 static Color _sentMessageLightColor(BuildContext context) {
    return Theme.of(context).colorScheme.primary;
  }

  static Color _sentMessageDarkColor(BuildContext context) {
    return Theme.of(context).colorScheme.primaryContainer;
  }

  static Color _receivedMessageLightColor(BuildContext context) {
    return Theme.of(context).colorScheme.surfaceContainerHighest;
  }

  static Color _receivedMessageDarkColor(BuildContext context) {
    return Theme.of(context).colorScheme.secondaryContainer;
  }

  // Message bubble styles
  static BoxDecoration sentMessageDecoration(BuildContext context) {
    return BoxDecoration(
      color: Theme.of(context).brightness == Brightness.light
          ? _sentMessageLightColor(context)
          : _sentMessageDarkColor(context),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
        bottomLeft: Radius.circular(16),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  static BoxDecoration receivedMessageDecoration(BuildContext context) {
    return BoxDecoration(
      color: Theme.of(context).brightness == Brightness.light
          ? _receivedMessageLightColor(context)
          : _receivedMessageDarkColor(context),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
        bottomRight: Radius.circular(16),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 2,
          offset: const Offset(0, 1),
        ),
      ],
    );
  }

  // Text styles with automatic contrast
  static TextStyle sentMessageTextStyle(BuildContext context) {
    final color = Theme.of(context).brightness == Brightness.light
        ? AppColors.sentMessageTextLight
        : AppColors.sentMessageTextDark;
    
    return Theme.of(context).textTheme.bodyMedium!.copyWith(
      color: color,
      fontSize: 16,
    );
  }

  static TextStyle receivedMessageTextStyle(BuildContext context) {
    final color = Theme.of(context).brightness == Brightness.light
        ? AppColors.receivedMessageTextLight
        : AppColors.receivedMessageTextDark;
    
    return Theme.of(context).textTheme.bodyMedium!.copyWith(
      color: color,
      fontSize: 16,
    );
  }

  static TextStyle messageTimeStyle(BuildContext context, bool isSent) {
    final colorScheme = Theme.of(context).colorScheme;
    final color = isSent 
        ? Colors.white.withOpacity(0.6) 
        : colorScheme.onSurface.withOpacity(0.6);
    
    return Theme.of(context).textTheme.labelSmall!.copyWith(
      color: color,
      fontSize: 12,
    );
  }
}