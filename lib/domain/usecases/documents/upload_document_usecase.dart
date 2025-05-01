import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/document.dart';
import '../../repositories/documents_repository.dart';

class UploadDocumentUseCase implements UseCase<Document, UploadDocumentParams> {
  final DocumentsRepository repository;

  UploadDocumentUseCase(this.repository);

  @override
  Future<Either<Failure, Document>> call(UploadDocumentParams params) async {
    return await repository.uploadDocument(params.file.path, params.name);
  }
}

class UploadDocumentParams extends Equatable {
  final File file;
  final String name;

  const UploadDocumentParams({
    required this.file,
    required this.name,
  });

  @override
  List<Object> get props => [file, name];
}
