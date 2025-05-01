import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../datasources/documents_remote_data_source.dart';
import '../datasources/visualization_remote_data_source.dart';
import '../../domain/entities/document.dart';
import '../../domain/entities/visualization.dart';
import '../../domain/repositories/documents_repository.dart';

class DocumentsRepositoryImpl implements DocumentsRepository {
  final DocumentsRemoteDataSource remoteDataSource;
  final VisualizationRemoteDataSource visualizationDataSource;

  DocumentsRepositoryImpl({
    required this.remoteDataSource,
    required this.visualizationDataSource,
  });

  @override
  Future<Either<Failure, List<Document>>> getDocuments() async {
    try {
      final documents = await remoteDataSource.getDocuments();
      return Right(documents);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Document>> uploadDocument(String filePath, String fileName) async {
    try {
      final document = await remoteDataSource.uploadDocument(File(filePath), fileName);
      return Right(document);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Document>> getDocumentDetails(String documentId) async {
    try {
      final document = await remoteDataSource.getDocumentDetails(documentId);
      return Right(document);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteDocument(String documentId) async {
    try {
      final result = await remoteDataSource.deleteDocument(documentId);
      return const Right(true);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Visualization>> generateVisualization({
    required String documentId,
    required String visualizationType,
  }) async {
    try {
      final visualization = await visualizationDataSource.generateVisualization(
        documentId: documentId,
        visualizationType: visualizationType,
      );
      return Right(visualization);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
