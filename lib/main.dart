import 'package:chat_oline_1/ui/addRoom/add_room_screen.dart';
import 'package:chat_oline_1/ui/chat/chat_thread.dart';
import 'package:chat_oline_1/ui/chatgpt/chat_screen_gpt.dart';
import 'package:chat_oline_1/ui/home/home_screen.dart';
import 'package:chat_oline_1/ui/login/login_screen.dart';
import 'package:chat_oline_1/ui/register/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApplication());
}
// Future <void>main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await dotenv.load(fileName: ".env");
//   runApp(const MyApplication());
// }
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   try {
//     await dotenv.load();
//   } catch (e) {
//     if (kDebugMode) {
//       print('Failed to load .env file: $e');
//     }
//   }
//   runApp(const MyApplication());
// }

class MyApplication extends StatelessWidget {
  const MyApplication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, widget) {
        Widget error = const Text('...rendering error...');
        if (widget is Scaffold || widget is Navigator) {
          error = Scaffold(body: Center(child: error));
        }
        ErrorWidget.builder = (errorDetails) => error;
        if (widget != null) return widget;
        throw ('widget is null');
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        //useMaterial3: true,
      ),
      routes: {
        RegisterScreen.routeName: (context) => RegisterScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        AddRoomScreen.routeName: (context) => AddRoomScreen(),
        ChatThread.routeName: (context) => ChatThread(),
        ChatScreenGpt.routeName: (context) => ChatScreenGpt(),
      },
      initialRoute: HomeScreen.routeName,
      home:  ChatScreenGpt(),
    );
  }
}
