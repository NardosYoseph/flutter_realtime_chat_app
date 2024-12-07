import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:real_time_chat_app/ui/screens/chat_screen.dart';
import 'package:real_time_chat_app/ui/screens/homeScreen.dart';
import 'package:real_time_chat_app/ui/screens/login_screen.dart';

import '../widgets/emailTextfield.dart';
import '../widgets/passwordTextField.dart';
import '../widgets/usernameTextField.dart';

class SignupScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Form(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Signup",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                      UsernameTextField(
                    controller: usernameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Username is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  
                  EmailTextField(
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  PasswordTextField(
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24),
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                     if(state is RegistrationSuccessState){
                      Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                     }
                         else if (state is RegistrationErrorState) {
                        // // Show error message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.errorMessage)),
                      // return  Text(state.errorMessage, style: TextStyle(color: Colors.red),);
                        );
                      }
                    },
                    builder: (context, state) {
                      if(state is RegisterStateLoading){
                        return CircularProgressIndicator();
                      }
                   
                  return ElevatedButton(
                        onPressed: () {
                          final email = emailController.text.trim();
                          final password = passwordController.text.trim();
                          final username = usernameController.text.trim();
                          if (email.isNotEmpty && password.isNotEmpty) {
                            // Dispatch the LoginEvent
                            context.read<AuthBloc>().add(
                              RegisterEvent(username,email, password)
                                );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Please fill in all fields')),
                            );
                          }
                        },
                        child: Text('Signup'),
                      );
                    },
                  ),
                   
                    
                
                  SizedBox(
                    height: 200,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
