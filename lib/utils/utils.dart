import 'package:toast/toast.dart';

class Utils{
  static void showToast(String msg) {
    Toast.show(msg, duration: Toast.lengthLong, gravity: Toast.bottom);
  }
}