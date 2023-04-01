import 'package:chat_oline_1/base/base.dart';
import 'package:chat_oline_1/date_base/my_data_base.dart';
import 'package:chat_oline_1/model/message.dart';
import 'package:chat_oline_1/model/room.dart';
import 'package:chat_oline_1/ui/chat/chat_veiw_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'messege_widget.dart';

class ChatThread extends StatefulWidget {
  static const String routeName = 'chat-thread';

  @override
  State<ChatThread> createState() => _ChatThreadState();
}

class _ChatThreadState extends BaseState<ChatThread, ChatViewModel>
    implements ChatNavigator {
  @override
  ChatViewModel initViewModel() {
    return ChatViewModel();
  }

  late Room room;
  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    room = ModalRoute.of(context)?.settings.arguments as Room;
    viewModel.room = room;
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.fill)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.transparent,
            title: Text(
              '${room.title}',
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert),
              ),
            ],
          ),
          body: Card(
            margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
            elevation: 18,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Expanded(
                    child: StreamBuilder<QuerySnapshot<Message>>(
                  stream: MyDataBase.getMessageCollection(room.id ?? "")
                      .orderBy('dataTime', descending: true)
                      .snapshots(),
                  builder: (BuildContext context, asyncSnapshot) {
                    if (asyncSnapshot.hasError) {
                      return const Center(
                        child: Text('Something Went Wrong '),
                      );
                    } else if (asyncSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    var data = asyncSnapshot.data?.docs
                        .map((docs) => docs.data())
                        .toList();
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.separated(
                        reverse: true,
                        itemBuilder: (BuildContext context, index) {
                          return MassageWidget(data![index]);
                        },
                        itemCount: data?.length ?? 0,
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 8,
                          );
                        },
                      ),
                    );
                  },
                )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Colors.black26,
                              ),
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(12))),
                          child: TextField(
                            controller: messageController,
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(12),
                                hintText: 'Your Message Her'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      InkWell(
                        onTap: () {
                          viewModel.send(messageController.text);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Theme.of(context).primaryColor,
                          ),
                          child: Row(
                            children: const [
                              Text(
                                'Send',
                                style: TextStyle(color: Colors.white),
                              ),
                              Icon(
                                Icons.send_sharp,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void clearMessageText() {
    messageController.text;
  }
}
