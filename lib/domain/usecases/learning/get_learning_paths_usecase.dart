import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/learning_path.dart';
import '../../repositories/learning_repository.dart';

class GetLearningPathsUseCase implements UseCase<List<LearningPath>, NoParams> {
  final LearningRepository repository;

  GetLearningPathsUseCase(this.repository);

  @override
  Future<Either<Failure, List<LearningPath>>> call([NoParams params = const NoParams()]) async {
    return await repository.getLearningPaths();
  }

  Future<Either<Failure, List<Quiz>>> getQuizzes() async {
    return await repository.getQuizzes();
  }

  Future<Either<Failure, Quiz>> getQuizById(String quizId) async {
    return await repository.getQuizById(quizId);
  }

  Future<Either<Failure, int>> submitQuizAnswers(String quizId, Map<String, String> answers) async {
    return await repository.submitQuizAnswers(quizId, answers);
  }
}
