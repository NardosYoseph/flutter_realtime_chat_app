import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/blocs/auth_bloc/auth_bloc.dart';
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
              decoration: BoxDecoration(color: const Color.fromARGB(255, 170, 18, 107)),
            width:double.infinity ,
            child: DrawerHeader(
                child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  child: Icon(
                    Icons.person,
                    size: 50,
                  ),
                ),
                SizedBox(height: 5,),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if(state is AuthenticatedState){
                    return Column(
                      children: [
                        Text('@${state.username}',style: TextStyle(color: Colors.white,fontSize: 14),),

                        Text(state.email,style: TextStyle(color: Colors.white),),
                      ],
                    );}
                      else{
                    return SizedBox();
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
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
            },
            child: ListTile(leading: Icon(Icons.home,),title: Text("Home"),))
            ,
          GestureDetector(
            onTap: (){
              context.read<AuthBloc>().add(LogoutEvent());
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
            },
            child: ListTile(leading: Icon(Icons.logout,),title: Text("Logout"),))
        ],
      ),
    );
  }
}
