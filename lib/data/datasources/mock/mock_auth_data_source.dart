import '../auth_remote_data_source.dart';
import '../../models/user_model.dart';
import '../../../core/error/exceptions.dart';

class MockAuthRemoteDataSource implements AuthRemoteDataSource {
  final Map<String, UserModel> _users = {
    'test@example.com': UserModel(
      id: '1',
      name: 'Test User',
      email: 'test@example.com',
      profileImage: null,
    ),
  };

  String? _currentToken;

  @override
  Future<UserModel> login(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    if (password == 'password123' && _users.containsKey(email)) {
      _currentToken = 'mock_token_${DateTime.now().millisecondsSinceEpoch}';
      return _users[email]!;
    } else {
      throw UnauthorizedException(message: 'Invalid email or password');
    }
  }

  @override
  Future<UserModel> register(String name, String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    if (_users.containsKey(email)) {
      throw ValidationException(message: 'Email already in use');
    }

    final newUser = UserModel(
      id: (_users.length + 1).toString(),
      name: name,
      email: email,
      profileImage: null,
    );

    _users[email] = newUser;
    _currentToken = 'mock_token_${DateTime.now().millisecondsSinceEpoch}';

    return newUser;
  }

  @override
  Future<void> logout() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    _currentToken = null;
  }
}
