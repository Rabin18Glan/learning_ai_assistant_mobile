import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/visualization.dart';
import '../../repositories/documents_repository.dart';
import 'package:equatable/equatable.dart';

class GenerateVisualizationUseCase implements UseCase<Visualization, GenerateVisualizationParams> {
  final DocumentsRepository repository;

  GenerateVisualizationUseCase(this.repository);

  @override
  Future<Either<Failure, Visualization>> call(GenerateVisualizationParams params) async {
    return await repository.generateVisualization(
      documentId: params.documentId,
      visualizationType: params.visualizationType,
    );
  }
}

class GenerateVisualizationParams extends Equatable {
  final String documentId;
  final String visualizationType; // 'mindmap', 'knowledge_graph', etc.

  const GenerateVisualizationParams({
    required this.documentId,
    required this.visualizationType,
  });

  @override
  List<Object?> get props => [documentId, visualizationType];
}
