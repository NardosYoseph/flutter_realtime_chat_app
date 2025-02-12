import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:real_time_chat_app/blocs/auth_bloc/auth_event.dart';
import 'package:real_time_chat_app/blocs/auth_bloc/auth_state.dart';
import 'package:real_time_chat_app/ui/screens/login_screen.dart';
import '../screens/homeScreen.dart';
import '../theme/appColors.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: isDarkMode ? AppColors.darkPrimary : AppColors.lightPrimary,
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: isDarkMode ? Colors.white : Colors.black, // Contrast background
                    radius: 40,
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: isDarkMode ? AppColors.darkPrimary : AppColors.lightPrimary, // Adaptive icon color
                    ),
                  ),
                  const SizedBox(height: 5),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is AuthenticatedState) {
                        return Column(
                          children: [
                            Text(
                              '@${state.username}',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: isDarkMode ? Colors.white : Colors.black, // Adaptive text
                              ),
                            ),
                            Text(
                              state.email,
                              style: TextStyle(
                                fontSize: 12,
                                color: isDarkMode ? Colors.white70 : Colors.black54, // Adaptive email text
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, color: isDarkMode ? Colors.white : Colors.black),
            title: Text("Home", style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.logout, color: isDarkMode ? Colors.white : Colors.black),
            title: Text("Logout", style: TextStyle(color: isDarkMode ? Colors.white : Colors.black)),
            onTap: () {
              context.read<AuthBloc>().add(const LogoutEvent());
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          ),
        ],
      ),
    );
  }
}
