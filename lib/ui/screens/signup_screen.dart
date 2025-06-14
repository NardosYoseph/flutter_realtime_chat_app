import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:real_time_chat_app/blocs/auth_bloc/auth_event.dart';
import 'package:real_time_chat_app/blocs/auth_bloc/auth_state.dart';
import 'package:real_time_chat_app/ui/screens/homeScreen.dart';
import 'package:real_time_chat_app/ui/screens/login_screen.dart';
import '../widgets/emailTextfield.dart';
import '../widgets/passwordTextField.dart';
import '../widgets/usernameTextField.dart';
import 'package:flare_flutter/flare_actor.dart';
import '../widgets/teddyControlls.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController usernameController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();  
  // Add GlobalKey
final teddyControls = TeddyControls();
final FocusNode passwordFocusNode = FocusNode();
@override
void initState() {
  super.initState();
  passwordFocusNode.addListener(() {
    teddyControls.coverEyes(passwordFocusNode.hasFocus);
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Form(
                key: _formKey,  // Set the GlobalKey
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // App Header
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Text(
                          //   "Signup",
                          //   style: TextStyle(
                          //     fontSize: 30,
                          //     fontWeight: FontWeight.bold,
                          //     // color: Colors.purple, // Primary color
                          //   ),
                          // ),
                        ],
                      ),
                      const SizedBox(height: 20),

                                  SizedBox(
              height: 300,
              child: FlareActor(
                'assets/Teddy.flr',
                controller: teddyControls,
                animation: "idle",
              ),
            ),
                      const SizedBox(height: 20),

                      UsernameTextField(
                        controller: usernameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Username is required';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          teddyControls.lookAtTextField(value);
                        },
                      ),
                      const SizedBox(height: 16),

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
                       onChanged: (value) {
                          teddyControls.lookAtTextField(value);
                        },
                      ),
                      const SizedBox(height: 16),

                      // Password input field
                      PasswordTextField(
                        controller: passwordController,
                      focusNode: passwordFocusNode,
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
                      const SizedBox(height: 24),

                      // Signup Button
                      BlocConsumer<AuthBloc, AuthState>(
                        listener: (context, state) {
                          if (state is RegistrationSuccessState) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const HomePage()),
                            );
                          } else if (state is RegistrationErrorState) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.errorMessage)),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is RegisterStateLoading) {
                            return const CircularProgressIndicator();
                          }
                          return SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState?.validate() ?? false) {
                                  final email = emailController.text.trim();
                                  final password = passwordController.text.trim();
                                  final username = usernameController.text.trim();
                                  context.read<AuthBloc>().add(
                                    RegisterEvent(username:username, email:email, password:password),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Please fill in all fields')),
                                  );
                                }
                              },
                              // style: ElevatedButton.styleFrom(
                              //   // backgroundColor: Colors.purple, // Button with primary color
                              //   padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                              //   shape: RoundedRectangleBorder(
                              //     borderRadius: BorderRadius.circular(12),
                              //   ),
                              // ),
                              child: const Text('Signup', style: TextStyle(fontSize: 16)),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 40),

                      // Switch to Login screen
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(
                              "Already have an account? ",
                              style: TextStyle(fontSize: 16),
                            ),
                          TextButton(
                            child: const Text(
                              "Login",
                              style: TextStyle(fontSize: 16),
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
