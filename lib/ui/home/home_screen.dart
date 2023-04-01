import 'package:chat_oline_1/base/base.dart';
import 'package:chat_oline_1/shared_data.dart';
import 'package:chat_oline_1/ui/addRoom/add_room_screen.dart';
import 'package:chat_oline_1/ui/home/home_veiw_model.dart';
import 'package:chat_oline_1/ui/home/roow_wdiget.dart';
import 'package:chat_oline_1/ui/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'Home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen, HomeViewModel>
    implements HomeNavigator {
  @override
  HomeViewModel initViewModel() {
    return HomeViewModel();
  }

  @override
  void initState() {
    super.initState();
    viewModel.loadRooms();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => viewModel,
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  image: AssetImage('assets/images/background.png'),
                  fit: BoxFit.fill)),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              backgroundColor: Colors.transparent,
              title: const Text(
                'ChatApp',
              ),
              actions: [
                InkWell(
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    SharedData.user = null;
                    Navigator.pushReplacementNamed(
                        context, LoginScreen.routeName);
                  },
                  child: const Icon(Icons.logout),
                ),
              ],
            ),
            body: Column(
              children: [
                Expanded(child: Consumer<HomeViewModel>(
                  builder: (buildContext, homeViewModel, _) {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12),
                      itemBuilder: (_, index) {
                        return Roomwdiget(homeViewModel.rooms[index]);
                      },
                      itemCount: homeViewModel.rooms.length,
                    );
                  },
                )),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, AddRoomScreen.routeName);
              },
              child: const Icon(Icons.add),
            ),
          ),
        ));
  }
}
