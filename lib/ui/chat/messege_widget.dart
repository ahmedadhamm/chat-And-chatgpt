import 'package:chat_oline_1/Utils/utils_data.dart';
import 'package:chat_oline_1/model/message.dart';
import 'package:chat_oline_1/shared_data.dart';
import 'package:flutter/material.dart';

class MassageWidget extends StatelessWidget {
  Message message;

  MassageWidget(this.message);

  @override
  Widget build(BuildContext context) {
    return message.senderId == SharedData.user?.id
        ? SentMessage(message.content!, message.dataTime!)
        : ReciveveddMessage(
            message.content!, message.dataTime!, message.senderName!);
  }
}

class SentMessage extends StatelessWidget {
  int dataTime;
  String content;

  SentMessage(this.content, this.dataTime, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(24),
                topLeft: Radius.circular(24),
                bottomLeft: Radius.circular(24),
                // bottomRight: Radius.circular(24),
              )),
          child: Text(
            content,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        Text(
          formatMessageData(dataTime),
        ),
        //Text('${formatMessageData(dataTime)}'),
      ],
    );
  }
}

class ReciveveddMessage extends StatelessWidget {
  String senderName;
  int dataTime;
  String content;

  ReciveveddMessage(this.content, this.dataTime, this.senderName);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(senderName),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
              color: Color(0xFFF8F8F8),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(24),
                topLeft: Radius.circular(24),
                bottomLeft: Radius.circular(24),
                // bottomRight: Radius.circular(24),
              )),
          child: Text(
            content,
            style: const TextStyle(
              color: Color(0xFF787993),
            ),
          ),
        ),
        Text(formatMessageData(dataTime)),
      ],
    );
  }
}
