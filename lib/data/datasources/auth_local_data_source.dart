import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../../core/error/exceptions.dart';

abstract class AuthLocalDataSource {
  Future<UserModel?> getLastLoggedInUser();
  Future<void> cacheUser(UserModel user);
  Future<void> clearUser();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;
  final String userKey = 'CACHED_USER';

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<UserModel?> getLastLoggedInUser() async {
    try {
      final jsonString = sharedPreferences.getString(userKey);
      if (jsonString == null) return null;
      
      return UserModel.fromJson(json.decode(jsonString));
    } catch (e) {
      throw CacheException(message: 'Failed to retrieve cached user');
    }
  }

  @override
  Future<void> cacheUser(UserModel user) async {
    try {
      await sharedPreferences.setString(
        userKey,
        json.encode(user.toJson()),
      );
    } catch (e) {
      throw CacheException(message: 'Failed to cache user');
    }
  }

  @override
  Future<void> clearUser() async {
    try {
      await sharedPreferences.remove(userKey);
    } catch (e) {
      throw CacheException(message: 'Failed to clear cached user');
    }
  }
}
