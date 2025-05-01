import '../../domain/entities/visualization.dart';

class VisualizationModel extends Visualization {
  const VisualizationModel({
    required String id,
    required String documentId,
    required String type,
    required Map<String, dynamic> data,
    required DateTime createdAt,
  }) : super(
          id: id,
          documentId: documentId,
          type: type,
          data: data,
          createdAt: createdAt,
        );

  factory VisualizationModel.fromJson(Map<String, dynamic> json) {
    return VisualizationModel(
      id: json['id'],
      documentId: json['document_id'],
      type: json['type'],
      data: json['data'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'document_id': documentId,
      'type': type,
      'data': data,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
