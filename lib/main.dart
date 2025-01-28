import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:real_time_chat_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:real_time_chat_app/blocs/chat_bloc/chat_bloc.dart';
import 'package:real_time_chat_app/blocs/user_bloc/user_bloc.dart';
import 'package:real_time_chat_app/data/repositories/auth_repository.dart';
import 'package:real_time_chat_app/data/repositories/chat_repository.dart';
import 'package:real_time_chat_app/data/repositories/user_repository.dart';
import 'package:real_time_chat_app/ui/screens/homeScreen.dart';
import 'package:real_time_chat_app/ui/screens/login_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
 final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  HydratedBloc.storage = storage;
  await initHiveForFlutter();
  runApp(MyApp());
}
Future<void> initHiveForFlutter() async {
  await Hive.initFlutter();
}
class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AuthRepository authRepository = AuthRepository();
    ChatRepository chatRepository = ChatRepository();
    UserRepository userRepository = UserRepository();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(authRepository),
        ),
        BlocProvider(
          create: (context) => ChatBloc(chatRepository, userRepository),
        ),
        BlocProvider(
          create: (context) => UserBloc(userRepository, chatRepository),
        ),
      ],
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          // Choose the initial screen based on the auth state
          Widget initialScreen;

          if (state is AuthenticatedState) {
            initialScreen = HomePage(); // Replace with your main app screen
          } else if (state is LoggedOutState) {
            initialScreen = LoginScreen();
          } else {
            initialScreen = LoginScreen(); // Optional loading screen
          }

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter chat app',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: initialScreen,
          );
        },
      ),
    );
  }
}
