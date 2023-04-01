import 'package:chat_oline_1/base/base.dart';
import 'package:chat_oline_1/date_base/my_data_base.dart';
import 'package:chat_oline_1/model/room.dart';

abstract class AddRoomNavigator extends BaseNavigator {
  void goBack();
}

class AddRoomViewModel extends BaseViewModel<AddRoomNavigator> {
  void addRoom(String title, String des, String catId) async {
    navigator?.showLoadingDialog(message: 'Create Loading...');
    try {
      var res = await MyDataBase.createRoom(Room(
        title: title,
        description: des,
        catId: catId,
      ));
      navigator?.hideLoadingDialog();
      navigator?.showMessageDialog('Room Create Successfully',
          posActionTitle: 'ok', posAction: () {
        navigator?.goBack();
      }, isDismissible: false);
    } catch (e) {
      navigator?.hideLoadingDialog();
      navigator?.showMessageDialog('something went wrong ${e.toString()}');
    }
  }
}
