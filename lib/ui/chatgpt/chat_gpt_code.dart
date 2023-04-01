// import 'package:flutter/material.dart';
// import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//
//   ChatGBTcode chatGBTcode = ChatGBTcode();
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Chat App'),
//         ),
//         body: Column(
//           children: <Widget>[
//             Expanded(
//               child: ListView.builder(
//                 itemCount: chatGBTcode.messages.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return ListTile(
//                     title: Text(chatGBTcode.messages[index]['text']),
//                     subtitle: Text(chatGBTcode.messages[index]['sender']),
//                   );
//                 },
//               ),
//             ),
//             TextField(
//               decoration: const InputDecoration(
//                 hintText: 'Enter a message',
//               ),
//               onSubmitted: (String message) {
//                 chatGBTcode.sendMessage(message);
//                 setState(() {});
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
