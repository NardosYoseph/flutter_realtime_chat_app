import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../themeProvider.dart';
import 'package:real_time_chat_app/ui/screens/userSearchScreen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return AppBar(
      title: const Text(
        "Chat App",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      elevation: 20,
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchUserScreen()),
            );
          },
        ),
        const SizedBox(width: 10),
        IconButton(
          icon: Icon(
            themeProvider.themeMode == ThemeMode.dark
                ? Icons.nightlight_round // Moon icon for dark mode
                : Icons.wb_sunny, // Sun icon for light mode
          ),
          onPressed: () {
            themeProvider.toggleTheme(themeProvider.themeMode != ThemeMode.dark);
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
