class Message {
  static const String collectionName = 'message';
  String? id;
  String? content;
  String? senderName;
  String? senderId;
  String? roomId;
  int? dataTime;
  Message({this.id,this.content,
    this.senderId,this.senderName,this.dataTime,this.roomId});
  Message.fromFireStore(Map<String,dynamic>data){
    id = data ['id'];
    content = data ['content'];
    senderName = data ['senderName'];
    senderId = data ['senderId'];
    roomId = data ['roomId'];
    dataTime = data ['dataTime'];
  }
  Map<String,dynamic>toFireStore(){
    return{
      'id':id,
      'content':content,
      'senderName':senderName,
      'senderId':senderId,
      'roomId':roomId,
      'dataTime':dataTime,
    };
  }
}
