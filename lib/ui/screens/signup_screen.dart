import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:lottie/lottie.dart';
import 'package:real_time_chat_app/blocs/auth_bloc/auth_bloc.dart';
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
      body: Stack(
        children: [
          // Background animation or gradient
          // Positioned.fill(
          //   child: Lottie.asset(
          //     'assets/background_animation.json', // You can replace this with any background animation you prefer
          //     repeat: true,
          //     animate: true,
          //   ),
          // ),
          
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Form(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // App Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Signup",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple, // Primary color
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),

                      // // Friendly Teddy Bear Animation
                      // Lottie.asset(
                      //   'assets/teddy_bear.json', // Friendly character animation
                      //   height: 150,
                      //   width: 150,
                      //   repeat: true,
                      //   animate: true,
                      // ),

                      // Username input field
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

                      // Email input field
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

                      // Password input field
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

                      // Signup Button
                      BlocConsumer<AuthBloc, AuthState>(
                        listener: (context, state) {
                          if (state is RegistrationSuccessState) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => HomePage()),
                            );
                          } else if (state is RegistrationErrorState) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.errorMessage)),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is RegisterStateLoading) {
                            return CircularProgressIndicator();
                          }
                          return ElevatedButton(
                            onPressed: () {
                              final email = emailController.text.trim();
                              final password = passwordController.text.trim();
                              final username = usernameController.text.trim();
                              if (email.isNotEmpty && password.isNotEmpty) {
                                context.read<AuthBloc>().add(
                                  RegisterEvent(username, email, password),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Please fill in all fields')),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple, // Button with primary color
                              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text('Signup', style: TextStyle(fontSize: 18,color: Colors.white)),
                          );
                        },
                      ),

                      SizedBox(height: 40),

                      // Switch to Login screen
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            child: Text(
                              "Already have an account? Login",
                              style: TextStyle(color: Colors.purple),
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => LoginScreen()),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
