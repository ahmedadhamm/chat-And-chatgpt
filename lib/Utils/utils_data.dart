import 'package:intl/intl.dart';

String formatMessageData(int messageDatTime) {
  DateTime dataTime = DateTime.fromMicrosecondsSinceEpoch(messageDatTime);
  DateFormat dateFormat = DateFormat('hh:mm a');
  return dateFormat.format(dataTime);
}
