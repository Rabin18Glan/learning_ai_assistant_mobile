import 'package:dartz/dartz.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../datasources/learning_remote_data_source.dart';
import '../../domain/entities/learning_path.dart';
import '../../domain/repositories/learning_repository.dart';

class LearningRepositoryImpl implements LearningRepository {
  final LearningRemoteDataSource remoteDataSource;

  LearningRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<LearningPath>>> getLearningPaths() async {
    try {
      final learningPaths = await remoteDataSource.getLearningPaths();
      return Right(learningPaths);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on UnauthorizedException catch (e) {
      return Left(AuthFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Quiz>>> getQuizzes() async {
    try {
      final quizzes = await remoteDataSource.getQuizzes();
      return Right(quizzes);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on UnauthorizedException catch (e) {
      return Left(AuthFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Quiz>> getQuizById(String quizId) async {
    try {
      final quiz = await remoteDataSource.getQuizById(quizId);
      return Right(quiz);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on UnauthorizedException catch (e) {
      return Left(AuthFailure(message: e.message));
    } on NotFoundException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> submitQuizAnswers(String quizId, Map<String, String> answers) async {
    try {
      final score = await remoteDataSource.submitQuizAnswers(quizId, answers);
      return Right(score);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on UnauthorizedException catch (e) {
      return Left(AuthFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
