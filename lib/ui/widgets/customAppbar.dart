import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../themeProvider.dart';
import 'package:real_time_chat_app/ui/screens/userSearchScreen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final theme = Theme.of(context);

    return AppBar(
      titleSpacing: 10,
      title:  Text(
          "PingMe",
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.search,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SearchUserScreen()),
            );
          },
        ),
        const SizedBox(width: 10),
        IconButton(
          icon: Icon(
            themeProvider.themeMode == ThemeMode.dark
                ? Icons.nightlight_round
                : Icons.wb_sunny, 
          ),
          onPressed: () {
            themeProvider
                .toggleTheme(themeProvider.themeMode != ThemeMode.dark);
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
