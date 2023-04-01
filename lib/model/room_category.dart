class RoomCategory {
  String id;
  String name;
  String imageName;

  RoomCategory({required this.id, required this.name, required this.imageName});

  static List<RoomCategory> getRoomCategories() {
    return [
      RoomCategory(id: 'movies', name: 'Movies', imageName: 'movies.png'),
      RoomCategory(id: 'music', name: 'Music', imageName: 'music.png'),
      RoomCategory(id: 'sport', name: 'Sport', imageName: 'sport.png'),
    ];
  }

  static RoomCategory getCategoryById(String id) {
    switch (id) {
      case 'movies':
        {
          return RoomCategory(
              id: 'movies', name: 'Movies', imageName: 'movies.png');
        }
      case 'music':
        {
          return RoomCategory(
              id: 'music', name: 'Music', imageName: 'music.png');
        }
      case 'sport':
        {
          return RoomCategory(
              id: 'sport', name: 'Sport', imageName: 'sport.png');
        }
    }
    return RoomCategory(id: 'movies', name: 'Movies', imageName: 'movies.png');
  }
}
