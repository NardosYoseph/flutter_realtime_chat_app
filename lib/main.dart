import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
import 'package:real_time_chat_app/data/repositories/user_repository.dart';
import 'package:real_time_chat_app/ui/screens/homeScreen.dart';
import 'package:real_time_chat_app/ui/screens/login_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:real_time_chat_app/ui/screens/news_screen.dart';
import 'themeProvider.dart';
import 'ui/theme/appTheme.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling background message: ${message.messageId}");
}
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> setupFlutterNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setupFlutterNotifications();
FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  HydratedBloc.storage = storage;
  await Hive.initFlutter();
  final graphqlBox = await Hive.openBox<Map<dynamic, dynamic>>('graphql_cache');
 FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
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
    setupFirebaseMessaging();
    
  }

  void setupFirebaseMessaging() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Request permission
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User granted permission for notifications.");
    }

    // Get FCM Token
    String? token = await messaging.getToken();
    print("FCM Token: $token");

    // Listen for messages when the app is in foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Received message: ${message.notification?.title}");
      showNotification(message);
    });

    // When app is opened from a notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("Opened from notification: ${message.notification?.title}");
    });
  }

  // Show a notification
  void showNotification(RemoteMessage message) async {
    var android = AndroidNotificationDetails(
      'channel_id', 'Chat Messages',
      importance: Importance.max,
      priority: Priority.high,
    );

    var details = NotificationDetails(android: android);

    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title,
      message.notification?.body,
      details,
    );
  }
  @override
  Widget build(BuildContext context) {
    AuthRepository authRepository = AuthRepository();
    ChatRepository chatRepository = ChatRepository();
    UserRepository userRepository = UserRepository();

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
            create: (context) => AuthBloc(authRepository),
          ),
          BlocProvider(
            create: (context) => ChatBloc(chatRepository, userRepository),
          ),
          BlocProvider(
            create: (context) => UserBloc(userRepository, chatRepository),
          ),
        ],
        child: GraphQLProvider(
          client: client,
          child: Builder(
            builder: (context) {
              final themeProvider = Provider.of<ThemeProvider>(context); // Access ThemeProvider here
              return BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  Widget initialScreen = (state is AuthenticatedState) ? HomePage() : LoginScreen();
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: 'Flutter Chat App',
                     theme: AppThemes.lightTheme, // Use your custom light theme
                    darkTheme: AppThemes.darkTheme,
                    themeMode: themeProvider.themeMode, // Use themeMode from ThemeProvider
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