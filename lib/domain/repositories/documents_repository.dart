import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/document.dart';
import '../entities/visualization.dart';

abstract class DocumentsRepository {
  Future<Either<Failure, List<Document>>> getDocuments();
  Future<Either<Failure, Document>> uploadDocument(
      String filePath, String fileName);
  Future<Either<Failure, Document>> getDocumentDetails(String documentId);
  Future<Either<Failure, bool>> deleteDocument(String documentId);
  Future<Either<Failure, Visualization>> generateVisualization({
    required String documentId,
    required String visualizationType,
  });
}
