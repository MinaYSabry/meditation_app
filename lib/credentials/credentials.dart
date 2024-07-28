import 'package:shared_preferences/shared_preferences.dart';

class AppUserCredentials {
  static SharedPreferences? sharedPref;

  static Future<SharedPreferences?> storeCredentials({
    required bool? isLoggedIn,
    required String? userDocID,
  }) async {
    sharedPref = await SharedPreferences.getInstance();
    await sharedPref?.setBool('isLoggedIn', isLoggedIn!);
    await sharedPref?.setString('userDocId', userDocID!);

    return sharedPref;
  }
}
