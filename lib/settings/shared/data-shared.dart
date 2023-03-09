import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  static int? userID;
  static String? userName;
  static String? userRole;
  SharedPreferences? prefs;

  Future loadData() async {
    final prefs = await SharedPreferences.getInstance();
    userID = prefs.getInt('userID');
    userName = prefs.getString('userName');
    userRole = prefs.getString('userRole');
  }
}
