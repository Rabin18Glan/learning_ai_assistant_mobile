import 'package:equatable/equatable.dart';

class Visualization extends Equatable {
  final String id;
  final String documentId;
  final String type; // 'mindmap', 'knowledge_graph', etc.
  final Map<String, dynamic> data;
  final DateTime createdAt;

  const Visualization({
    required this.id,
    required this.documentId,
    required this.type,
    required this.data,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, documentId, type, data, createdAt];
}
