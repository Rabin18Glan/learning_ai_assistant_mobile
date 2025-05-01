import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/document.dart';
import '../../repositories/documents_repository.dart';

class GetDocumentsUseCase implements UseCase<List<Document>, NoParams> {
  final DocumentsRepository repository;

  GetDocumentsUseCase(this.repository);

  @override
  Future<Either<Failure, List<Document>>> call([NoParams params = const NoParams()]) async {
    return await repository.getDocuments();
  }
}
