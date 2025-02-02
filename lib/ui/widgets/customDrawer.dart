import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:real_time_chat_app/blocs/auth_bloc/auth_event.dart';
import 'package:real_time_chat_app/blocs/auth_bloc/auth_state.dart';
import 'package:real_time_chat_app/ui/screens/login_screen.dart';

import '../screens/homeScreen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
              
            width:double.infinity ,
            child: DrawerHeader(
                child: Column(
              children: [
                const CircleAvatar(
                  radius: 40,
                  child: Icon(
                    Icons.person,
                    size: 50,
                  ),
                ),
                const SizedBox(height: 5,),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if(state is AuthenticatedState){
                    return Column(
                      children: [
                        Text('@${state.username}',style: const TextStyle(fontSize: 14),),
                        Text(state.email,),
                      ],
                    );}
                      else{
                    return const SizedBox();
                  }
                  }
                
                )
              ],
            )),
          ),
          GestureDetector(
            onTap: (){
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
            },
            child: const ListTile(leading: Icon(Icons.home,),title: Text("Home"),))
            ,
          GestureDetector(
            onTap: (){
              context.read<AuthBloc>().add(LogoutEvent());
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
            },
            child: const ListTile(leading: Icon(Icons.logout,),title: Text("Logout"),))
        ],
      ),
    );
  }
}

