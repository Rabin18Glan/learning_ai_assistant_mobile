import '../visualization_remote_data_source.dart';
import '../../models/visualization_model.dart';
import 'package:uuid/uuid.dart';

class MockVisualizationDataSource implements VisualizationRemoteDataSource {
  final _visualizations = <VisualizationModel>[];
  final _uuid = Uuid();

  @override
  Future<VisualizationModel> generateVisualization({
    required String documentId,
    required String visualizationType,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // Create mock visualization data based on type
    Map<String, dynamic> data;
    
    if (visualizationType == 'mindmap') {
      data = _createMockMindMapData();
    } else if (visualizationType == 'knowledge_graph') {
      data = _createMockKnowledgeGraphData();
    } else {
      data = {'message': 'Unsupported visualization type'};
    }

    final visualization = VisualizationModel(
      id: _uuid.v4(),
      documentId: documentId,
      type: visualizationType,
      data: data,
      createdAt: DateTime.now(),
    );

    _visualizations.add(visualization);
    return visualization;
  }

  @override
  Future<List<VisualizationModel>> getVisualizations(String documentId) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    return _visualizations
        .where((v) => v.documentId == documentId)
        .toList();
  }

  Map<String, dynamic> _createMockMindMapData() {
    return {
      'nodes': [
        {
          'id': 'root',
          'label': 'Main Topic',
          'children': [
            {
              'id': 'subtopic1',
              'label': 'Subtopic 1',
              'children': [
                {'id': 'detail1', 'label': 'Detail 1'},
                {'id': 'detail2', 'label': 'Detail 2'},
              ]
            },
            {
              'id': 'subtopic2',
              'label': 'Subtopic 2',
              'children': [
                {'id': 'detail3', 'label': 'Detail 3'},
                {'id': 'detail4', 'label': 'Detail 4'},
              ]
            },
          ]
        }
      ]
    };
  }

  Map<String, dynamic> _createMockKnowledgeGraphData() {
    return {
      'nodes': [
        {'id': 'concept1', 'label': 'Concept 1'},
        {'id': 'concept2', 'label': 'Concept 2'},
        {'id': 'concept3', 'label': 'Concept 3'},
        {'id': 'concept4', 'label': 'Concept 4'},
      ],
      'edges': [
        {'source': 'concept1', 'target': 'concept2', 'label': 'relates to'},
        {'source': 'concept2', 'target': 'concept3', 'label': 'leads to'},
        {'source': 'concept1', 'target': 'concept4', 'label': 'influences'},
        {'source': 'concept3', 'target': 'concept4', 'label': 'part of'},
      ]
    };
  }
}
