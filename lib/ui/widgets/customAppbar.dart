import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white),
      title: const Text("MyChat",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
      backgroundColor: const Color.fromARGB(255, 170, 18, 107),
      elevation: 20,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); // Set the height of the AppBar
}
