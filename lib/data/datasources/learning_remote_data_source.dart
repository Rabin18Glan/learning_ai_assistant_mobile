import '../api/api_client.dart';
import '../models/learning_path_model.dart';
import '../../core/error/exceptions.dart';

abstract class LearningRemoteDataSource {
  Future<List<LearningPathModel>> getLearningPaths();
  Future<List<QuizModel>> getQuizzes();
  Future<QuizModel> getQuizById(String quizId);
  Future<int> submitQuizAnswers(String quizId, Map<String, String> answers);
}

class LearningRemoteDataSourceImpl implements LearningRemoteDataSource {
  final ApiClient apiClient;

  LearningRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<LearningPathModel>> getLearningPaths() async {
    try {
      final response = await apiClient.get('/learning/paths');
      
      return (response['learning_paths'] as List)
          .map((path) => LearningPathModel.fromJson(path))
          .toList();
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<QuizModel>> getQuizzes() async {
    try {
      final response = await apiClient.get('/learning/quizzes');
      
      return (response['quizzes'] as List)
          .map((quiz) => QuizModel.fromJson(quiz))
          .toList();
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<QuizModel> getQuizById(String quizId) async {
    try {
      final response = await apiClient.get('/learning/quizzes/$quizId');
      
      return QuizModel.fromJson(response['quiz']);
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<int> submitQuizAnswers(String quizId, Map<String, String> answers) async {
    try {
      final response = await apiClient.post(
        '/learning/quizzes/$quizId/submit',
        body: {
          'answers': answers,
        },
      );
      
      return response['score'];
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
