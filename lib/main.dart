import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:provider/provider.dart';
import 'package:real_time_chat_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:real_time_chat_app/blocs/auth_bloc/auth_state.dart';
import 'package:real_time_chat_app/blocs/chat_bloc/chat_bloc.dart';
import 'package:real_time_chat_app/blocs/user_bloc/user_bloc.dart';
import 'package:real_time_chat_app/data/repositories/auth_repository.dart';
import 'package:real_time_chat_app/data/repositories/chat_repository.dart';
import 'package:real_time_chat_app/data/repositories/presence_repository.dart';
import 'package:real_time_chat_app/data/repositories/user_repository.dart';
import 'package:real_time_chat_app/ui/screens/homeScreen.dart';
import 'package:real_time_chat_app/ui/screens/login_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'blocs/presence/presence_bloc.dart';
import 'data/service/user_status_service.dart';
import 'firebase/notification_service.dart';
import 'themeProvider.dart';
import 'ui/theme/appColors.dart';
import 'ui/theme/appTheme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final userStatusService = UserStatusService();
  userStatusService.setupAppLifecycleListener();
  await userStatusService.handleAppStart();
AppColors.lightColorScheme = ColorScheme.fromSeed(
    seedColor: AppColors.seedColor,
    brightness: Brightness.light,
  );
  
  AppColors.darkColorScheme = ColorScheme.fromSeed(
    seedColor: AppColors.seedColor,
    brightness: Brightness.dark,
  );
  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  HydratedBloc.storage = storage;
  await Hive.initFlutter();
  final graphqlBox = await Hive.openBox<Map<dynamic, dynamic>>('graphql_cache');
 
 FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await NotificationService.initialize();
  runApp(MyApp(graphqlBox: graphqlBox));
}

class MyApp extends StatefulWidget {
  final Box<Map<dynamic, dynamic>> graphqlBox;

  MyApp({super.key, required this.graphqlBox});

  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthRepository authRepository = AuthRepository();
    ChatRepository chatRepository = ChatRepository();
    UserRepository userRepository = UserRepository();
    PresenceRepository presenceRepository = PresenceRepository();

    final client = ValueNotifier(
      GraphQLClient(
        cache: GraphQLCache(store: HiveStore(widget.graphqlBox)), // Use HiveStore for caching
        link: HttpLink('https://your-graphql-api.com/graphql'), // Example public GraphQL API endpoint
      ),
    );

    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(), // Provide the ThemeProvider
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(authRepository,userRepository),
          ),
          BlocProvider(
            create: (context) => ChatBloc(chatRepository, userRepository,presenceRepository),
          ),
          BlocProvider(
            create: (context) => UserBloc(userRepository, chatRepository),
          ),
        ],
        child: GraphQLProvider(
          client: client,
          child: Builder(
            builder: (context) {
              final themeProvider = Provider.of<ThemeProvider>(context); 
              return BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  Widget initialScreen = (state is AuthenticatedState) ? HomePage() : LoginScreen();
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: 'Flutter Chat App',
                     theme: AppTheme.lightTheme, 
                    darkTheme: AppTheme.darkTheme,
                    themeMode: themeProvider.themeMode, 
                    home: initialScreen,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}