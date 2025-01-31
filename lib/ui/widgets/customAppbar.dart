import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_time_chat_app/ui/screens/userSearchScreen.dart';

import '../../themeProvider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
   final themeProvider = Provider.of<ThemeProvider>(context);

    return AppBar(
      // iconTheme: IconThemeData(color: Colors.white),
      title: const Text("Chat App",style: TextStyle(fontWeight: FontWeight.bold),),
     flexibleSpace: Container(
        decoration: BoxDecoration(
          // gradient: LinearGradient(
          //   colors: [
          //     Colors.purple,
          //                             Colors.purple, // Soft blue

          //   ],
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          // ),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.purple.withOpacity(0.5),
          //     blurRadius: 10,
          //     offset: const Offset(0, 4),
          //   ),
          // ],
        ),
      ),
      elevation: 20,
      actions: [
        Row(children: [IconButton(icon:Icon(Icons.search),
      onPressed: (){ Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchUserScreen()),
                    );
      },),SizedBox(width: 10,)],)
      ,
      Switch(
            value: themeProvider.themeMode == ThemeMode.dark,
            onChanged: (value) {
              themeProvider.toggleTheme(value); // Toggle theme
            },
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); // Set the height of the AppBar
}
