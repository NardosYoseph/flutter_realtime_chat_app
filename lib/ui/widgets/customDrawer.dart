import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:real_time_chat_app/blocs/auth_bloc/auth_event.dart';
import 'package:real_time_chat_app/blocs/auth_bloc/auth_state.dart';
import 'package:real_time_chat_app/ui/screens/login_screen.dart';
import '../screens/homeScreen.dart';
import '../theme/appTheme.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Drawer(
      backgroundColor: colorScheme.surfaceContainerHighest, // Use surface color for drawer background
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest, // Use surface variant for header
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: colorScheme.primary, // Use primary color for avatar bg
                    radius: 40,
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: colorScheme.onPrimary, // Use onPrimary for icon
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
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: colorScheme.onSurface, // Use onSurface for text
                              ),
                            ),
                            Text(
                              state.email,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurface.withOpacity(0.7), // Subdued text
                            ),),
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
            leading: Icon(Icons.home, color: colorScheme.onSurface), // Use onSurface for icons
            title: Text(
              "Home",
              style: theme.textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurface, // Use onSurface for text
              ),
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.logout, color: colorScheme.onSurface),
            title: Text(
              "Logout",
              style: theme.textTheme.bodyLarge?.copyWith(
                color: colorScheme.error, // Use error color for logout
              ),
            ),
            onTap: () {
              context.read<AuthBloc>().add(const LogoutEvent());
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}