import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/learning_path.dart';

abstract class LearningRepository {
  Future<Either<Failure, List<LearningPath>>> getLearningPaths();
  Future<Either<Failure, List<Quiz>>> getQuizzes();
  Future<Either<Failure, Quiz>> getQuizById(String quizId);
  Future<Either<Failure, int>> submitQuizAnswers(String quizId, Map<String, String> answers);
}
