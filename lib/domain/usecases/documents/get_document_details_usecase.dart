// import 'package:dartz/dartz.dart';
// import 'package:edusense_ai/core/error/failures.dart';
// import 'package:edusense_ai/core/usecases/usecase.dart';
// import 'package:edusense_ai/domain/entities/document.dart';
// import 'package:edusense_ai/domain/repositories/documents_repository.dart';
// import 'package:equatable/equatable.dart';

// class GetDocumentDetailsUseCase implements UseCase<Document, GetDocumentDetailsParams> {
//   final DocumentsRepository repository;

//   GetDocumentDetailsUseCase(this.repository);

//   @override
//   Future<Either<Failure, Document>> call(GetDocumentDetailsParams params) async {
//     return await repository.getDocuments(params.documentId);
//   }
// }

// class GetDocumentDetailsParams extends Equatable {
//   final String documentId;

//   const GetDocumentDetailsParams({required this.documentId});

//   @override
//   List<Object?> get props => [documentId];
// }
