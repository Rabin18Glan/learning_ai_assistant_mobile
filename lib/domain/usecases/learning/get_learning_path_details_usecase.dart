import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/learning_path.dart';
import '../../repositories/learning_repository.dart';
import 'package:equatable/equatable.dart';

// class GetLearningPathDetailsUseCase implements UseCase<LearningPath, GetLearningPathDetailsParams> {
//   final LearningRepository repository;

//   GetLearningPathDetailsUseCase(this.repository);

//   @override
//   Future<Either<Failure, LearningPath>> call(GetLearningPathDetailsParams params) async {
//     return await repository.getLearningPathDetails(params.pathId);
//   }
// }

class GetLearningPathDetailsParams extends Equatable {
  final String pathId;

  const GetLearningPathDetailsParams({required this.pathId});

  @override
  List<Object?> get props => [pathId];
}
