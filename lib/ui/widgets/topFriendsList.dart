import 'package:flutter/material.dart';

class TopFriendsList extends StatelessWidget {
  final List<Map<String, String>>
      users; // A list of users with 'name' and 'avatarUrl'

  const TopFriendsList({Key? key, required this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100, // Fixed height for the horizontal scroll
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.purpleAccent, // Set the border color
                        width: 3.0, // Optional: Set the border width
                      ),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Icon(Icons.person,size: 50,)),
                const SizedBox(height: 5),
                Text(
                  user['name']!,
                  style: const TextStyle(fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
