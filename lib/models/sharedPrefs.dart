import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences _sharedPrefs;
  String user;

  init() async {
    if (_sharedPrefs == null) {
      _sharedPrefs = await SharedPreferences.getInstance();
    }
  }

  void toggleAdminStatus(bool value) {
    _sharedPrefs.setBool('admin', value);
  }

  void toggleLoadingStatus(bool value) {
    _sharedPrefs.setBool('loading', value);
  }

  bool get loadingStatus {
    return _sharedPrefs.getBool('loading');
  }

  bool get adminStatus {
    return _sharedPrefs.getBool('admin');
  }
}
