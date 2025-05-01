import '../api/api_client.dart';
import '../models/user_model.dart';
import '../../core/error/exceptions.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(String name, String email, String password);
  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      // final response = await apiClient.post(
      //   '/auth/login',
      //   body: {'email': email, 'password': password},
      // );

      // Store token in secure storage (implement this)
      // final token = response['token'];
      // await secureStorage.write(key: 'auth_token', value: token);
      return UserModel(
        id: '1',
        name: 'Test User',
        email: 'test@example.com',
        profileImage: "https://example.com/profile.jpg",
      );

      // return UserModel.fromJson(_users);
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserModel> register(String name, String email, String password) async {
    try {
      final response = await apiClient.post(
        '/auth/register',
        body: {'name': name, 'email': email, 'password': password},
      );

      // Store token in secure storage (implement this)
      final token = response['token'];
      // await secureStorage.write(key: 'auth_token', value: token);

      return UserModel.fromJson(response['user']);
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> logout() async {
    try {
      await apiClient.post('/auth/logout');
      // Clear token from secure storage (implement this)
      // await secureStorage.delete(key: 'auth_token');
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
