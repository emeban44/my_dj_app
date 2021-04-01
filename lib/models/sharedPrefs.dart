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

  bool get isAdminInit {
    if (_sharedPrefs.get('admin') == null) {
      return false;
    }
  }

  void initializeAdmin() {
    _sharedPrefs.setBool('admin', false);
    _sharedPrefs.setBool('init', true);
  }

  bool get adminStatus {
    return _sharedPrefs.getBool('admin');
  }
}
