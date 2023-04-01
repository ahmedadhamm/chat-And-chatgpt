class Room {
  static const String collectionName = 'room';
  String? id;
  String? title;
  String? description;
  String? catId;

  Room({this.id, this.title, this.description, this.catId});

  Room.fromFireStore(Map<String, dynamic> data)
      : this(
          id: data['id'],
          description: data['description'],
          catId: data['catId'],
        );

  Map<String, dynamic> toFireStore() {
    return {
      "id": id,
      "description": description,
      "catId": catId,
    };
  }
}
