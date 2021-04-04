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

  void initalizeSongs() {
    if (_sharedPrefs.getBool('songsInit') == null) {
      _sharedPrefs.setBool('songsInit', true);
    }
    _sharedPrefs.setBool('songsInit', true);
  }

  bool get didSongsInit {
    if (_sharedPrefs.getBool('songsInit') == null) return false;
    return _sharedPrefs.getBool('songsInit');
  }

  void setUserId(value) {
    _sharedPrefs.setString('userId', value);
  }

  String get userId {
    return _sharedPrefs.getString('userId');
  }
}
