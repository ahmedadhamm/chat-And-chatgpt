import 'package:chat_oline_1/ui/addRoom/add_room_screen.dart';
import 'package:chat_oline_1/ui/chat/chat_thread.dart';
import 'package:chat_oline_1/ui/home/home_screen.dart';
import 'package:chat_oline_1/ui/login/login_screen.dart';
import 'package:chat_oline_1/ui/register/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApplication());
}

class MyApplication extends StatelessWidget {
  const MyApplication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      routes: {
        RegisterScreen.routeName: (context) => RegisterScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        AddRoomScreen.routeName: (context) => AddRoomScreen(),
        ChatThread.routeName: (context) => ChatThread(),
      },
      initialRoute: HomeScreen.routeName,
    );
  }
}
