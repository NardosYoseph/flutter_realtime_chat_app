import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_time_chat_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:real_time_chat_app/blocs/auth_bloc/auth_event.dart';
import 'package:real_time_chat_app/blocs/auth_bloc/auth_state.dart';
import 'package:real_time_chat_app/ui/screens/homeScreen.dart';
import 'package:real_time_chat_app/ui/screens/signup_screen.dart';

import '../widgets/emailTextfield.dart';
import '../widgets/passwordTextField.dart';
import '../widgets/teddyControlls.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

// final FlareControls teddyControls = FlareControls();
@override
void initState() {
  super.initState();
  passwordFocusNode.addListener(() {
    teddyControls.coverEyes(passwordFocusNode.hasFocus);
  });
}
@override
void dispose() {
  passwordFocusNode.dispose();
  super.dispose();
}

final teddyControls = TeddyControls();

final FocusNode passwordFocusNode = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    "Welcome!",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      // color: Colors.purple,
                    ),
                  ),
                  const SizedBox(height: 10),
                   const SizedBox(height: 20),
              SizedBox(
                height: 300,
                child: FlareActor(
                  'assets/Teddy.flr',
                  controller: teddyControls,
                  animation: "idle",
                ),
              ),
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
                    onChanged: (value){
                      teddyControls.lookAtTextField(value);
                    },
                  ),
                  const SizedBox(height: 16),
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
                      focusNode: passwordFocusNode,
              
                  ),
                  const SizedBox(height: 24),
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is AuthenticatedState) {
                        teddyControls.play("success");
                        Future.delayed(const Duration(seconds: 2), () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const HomePage()),
                        );});
                      } else if (state is AuthenticationErrorState) {
                        teddyControls.play("fail");
              
                        // Trigger teddy sad animation
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.errorMessage)),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is AuthStateLoading) {
                        return const CircularProgressIndicator();
                      }
                      return Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              // style: ElevatedButton.styleFrom(
                              // backgroundColor: Theme.of(context).colorScheme.primary,
                              //   shape: RoundedRectangleBorder(
                              //     borderRadius: BorderRadius.circular(12),
                              //   ),
                              //   padding: const EdgeInsets.symmetric(
                              //       vertical: 12, horizontal: 40),
                              //       textStyle: Theme.of(context).textTheme.labelLarge,
                              // ),
                              
                              onPressed: () {
                                  teddyControls.play("idle");
                                 if (_formKey.currentState?.validate() ?? false) {
                                    context.read<AuthBloc>().add(
                                      LoginEvent(
                                        email: emailController.text.trim(),
                                        password: passwordController.text.trim(),
                                      ),
                                    );
                                  }
                                 
                            
                              },
                                               child: const Text('Login', style: TextStyle(fontSize: 16)),
                            ),


                          ),
                          
// const SizedBox(height: 16),
// // Google Sign-In Button
// SizedBox(
//   width: double.infinity,
//   height: 50,
//   child: ElevatedButton(
//     style: ElevatedButton.styleFrom(
//       backgroundColor: Colors.white,
//       foregroundColor: Colors.black,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8),
//       ),
//       side: BorderSide(color: Colors.grey.shade300),
//     ),
//     onPressed: () {
//       teddyControls.play("idle");
//       context.read<AuthBloc>().add(GoogleSignInEvent());
//     },
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Image.asset(
//           'assets/google_logo.png',  // Add a Google logo asset
//           height: 34,
//           width: 34,
//         ),
//         const SizedBox(width: 10),
//         const Text('Sign in with Google'),
//       ],
//     ),
//   ),
  // )
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignupScreen()),
                          );
                        },
                        child: const Text(
                          "Sign up",
                          
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
