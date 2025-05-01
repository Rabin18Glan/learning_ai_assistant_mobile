class ApiConfig {
  static const String baseUrl = 'https://api.edusense.ai/v1';
  
  // API endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String documents = '/documents';
  static const String uploadDocument = '/documents/upload';
  static const String chats = '/chats';
  static const String learningPaths = '/learning/paths';
  static const String quizzes = '/learning/quizzes';
}
