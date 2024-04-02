import 'package:fridge/core/error/exceptions.dart';
import 'package:fridge/core/network/api_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSource(this.sharedPreferences);

  bool isFirstEntry();
  bool isLoggedIn();
  Future<void> updateToken(String? token);
  Future<void> signOut();
}

class AuthLocalDataSourceImpl extends AuthLocalDataSource {
  AuthLocalDataSourceImpl(super.sharedPreferences) {
    ApiConstants.token = sharedPreferences.getString(_token) ?? '';
  }
  
  final String _isFirstEntry = 'IS_FIRST_ENTRY';
  final String _authState = 'AUTH_STATE';
  final String _token = 'TOKEN';

  @override
  bool isFirstEntry() {
    try {
      bool firstEntry =  sharedPreferences.getBool(_isFirstEntry) ?? true;
      sharedPreferences.setBool(_isFirstEntry, false);
      return firstEntry;
    } on Exception catch(error) {
      throw LocalDatabaseException(message: error.toString());
    }
  }

  @override
  bool isLoggedIn() {
    try {
      String token = sharedPreferences.getString(_token) ?? '';
      ApiConstants.token = token;
      return sharedPreferences.getBool(_authState) ?? false;
    } on Exception catch(error) {
      throw LocalDatabaseException(message: error.toString());
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await sharedPreferences.setString(_token, '');
      await sharedPreferences.setBool(_authState, false);
      ApiConstants.token = '';
    } on Exception catch(error) {
      throw LocalDatabaseException(message: error.toString());
    }
  }

  @override
  Future<void> updateToken(String? token) async {
    try {
      await sharedPreferences.setString(_token, token ?? '');
      await sharedPreferences.setBool(_authState, true);
      ApiConstants.token = token ?? '';
    } on Exception catch(error) {
      throw LocalDatabaseException(message: error.toString());
    }
  }
}