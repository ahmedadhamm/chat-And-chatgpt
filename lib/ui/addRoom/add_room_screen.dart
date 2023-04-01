import 'package:chat_oline_1/base/base.dart';
import 'package:chat_oline_1/model/room_category.dart';
import 'package:chat_oline_1/ui/addRoom/add_room_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddRoomScreen extends StatefulWidget {
  static const String routeName = 'addRoom';

  @override
  State<AddRoomScreen> createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends BaseState<AddRoomScreen, AddRoomViewModel>
    implements AddRoomNavigator {
  @override
  AddRoomViewModel initViewModel() {
    return AddRoomViewModel();
  }

  List<RoomCategory> allCats = RoomCategory.getRoomCategories();
  late RoomCategory selectedRoomCategory;
  var fromKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var desController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedRoomCategory = allCats[0];
  }

  @override
  Widget build(BuildContext context) {
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
            title: const Text('AddRoom'),
          ),
          body: Card(
            margin: const EdgeInsets.all(24),
            elevation: 12,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Form(
                key: fromKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Create New Room',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Image.asset("assets/images/add_room_image.png"),
                    TextFormField(
                      controller: titleController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please Enter Room Title ';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(labelText: 'Room Name'),
                    ),
                    DropdownButton<RoomCategory>(
                        value: selectedRoomCategory,
                        items: allCats.map((cat) {
                          return DropdownMenuItem<RoomCategory>(
                            value: cat,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    "assets/images/movies.png",
                                    // Image.asset("assets/images${cat.imageName}",
                                    width: 48, height: 48,
                                  ),
                                ),
                                Text(cat.name),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (items) {
                          if (items == null) return;
                          setState(() {
                            selectedRoomCategory = items;
                          });
                        }),
                    TextFormField(
                      controller: desController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please Enter Room Description ';
                        }
                        return null;
                      },
                      maxLines: 3,
                      minLines: 3,
                      decoration:
                          const InputDecoration(labelText: 'Room Description'),
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                        ),
                        onPressed: () {
                          submit();
                        },
                        child: const Text('Create')),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void submit() {
    if (fromKey.currentState?.validate() == false) {
      return;
    }
    viewModel.addRoom(
        titleController.text, desController.text, selectedRoomCategory.id);
  }

  @override
  void goBack() {
    Navigator.pop(context);
  }
}
