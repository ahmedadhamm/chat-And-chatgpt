import 'package:chat_oline_1/model/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/message.dart';
import '../model/my_user.dart';

class MyDataBase {
  static CollectionReference<MyUser> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
            fromFirestore: (doc, _) => MyUser.fromFireStore(doc.data()!),
            toFirestore: (user, options) => user.toFireStore());
  }

  static CollectionReference<Room> getRoomsCollection() {
    return FirebaseFirestore.instance
        .collection(Room.collectionName)
        .withConverter<Room>(
            fromFirestore: (doc, _) => Room.fromFireStore(doc.data()!),
            toFirestore: (room, options) => room.toFireStore());
  }

  static Future<MyUser?> insertUser(MyUser user) async {
    var collection = getUsersCollection();
    var res = await (collection.doc(user.id)).set(user);
    return user;
  }

  static Future<MyUser?> getUserById(String uid) async {
    var collection = getUsersCollection();
    var docRef = collection.doc(uid);
    var res = await docRef.get();
    return res.data();
  }

  static Future<void> createRoom(Room room) {
    var docRef = getRoomsCollection().doc();
    room.id = docRef.id;
    return docRef.set(room);
  }

  static Future<List<Room>> loadRooms() async {
    var querySnapShot = await getRoomsCollection().get();
    return querySnapShot.docs
        .map((queryDocSnapShot) => queryDocSnapShot.data())
        .toList();
  }

  static CollectionReference<Message> getMessageCollection(String roomId) {
    return FirebaseFirestore.instance
        .collection(Room.collectionName)
        .doc(roomId)
        .collection(Message.collectionName)
        .withConverter<Message>(
          fromFirestore: (snapshot, options) =>
              Message.fromFireStore(snapshot.data()!),
          toFirestore: (message, options) => message.toFireStore(),
        );
  }

  static Future<void> sendMessage(String roomId, Message message) {
    var messageDoc = getMessageCollection(roomId).doc();
    message.id = messageDoc.id;
    return messageDoc.set(message);
  }
}
