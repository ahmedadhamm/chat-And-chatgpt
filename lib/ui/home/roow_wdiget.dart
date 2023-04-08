import 'package:chat_oline_1/model/room_category.dart';
import 'package:chat_oline_1/ui/chatgpt/chat_screen_gpt.dart';
import 'package:flutter/material.dart';

import '../../model/room.dart';
import '../chat/chat_thread.dart';

class Roomwdiget extends StatelessWidget {
  Room room;

  Roomwdiget(this.room);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ChatThread.routeName, arguments: room);
        //  Navigator.pushNamed(context, ChatScreenGpt.routeName, arguments: room);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 18,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                "assets/images/movies.png",
                width: 120,
                height: 120,
              ),
              // Image.asset("assets/images/${room.catId}.png",),
              Text(
                '${room.title}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
      ),
    );
  }
}
