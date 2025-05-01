import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../repositories/documents_repository.dart';
import 'package:equatable/equatable.dart';

class DeleteDocumentUseCase implements UseCase<bool, DeleteDocumentParams> {
  final DocumentsRepository repository;

  DeleteDocumentUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(DeleteDocumentParams params) async {
    return await repository.deleteDocument(params.documentId);
  }
}

class DeleteDocumentParams extends Equatable {
  final String documentId;

  const DeleteDocumentParams({required this.documentId});

  @override
  List<Object?> get props => [documentId];
}
