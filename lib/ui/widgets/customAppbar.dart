import 'package:flutter/material.dart';
import 'package:real_time_chat_app/ui/screens/userSearchScreen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white),
      title: const Text("Chat App",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
      backgroundColor: const Color.fromARGB(255, 170, 18, 107),
      elevation: 20,
      actions: [Row(children: [IconButton(icon:Icon(Icons.search),
      onPressed: (){ Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchUserScreen()),
                    );
      },),SizedBox(width: 10,)],)],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); // Set the height of the AppBar
}
