import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/documents/documents_bloc.dart';
import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/document.dart';
import '../../widgets/mind_map_visualization.dart';
import '../../widgets/knowledge_graph_visualization.dart';
import '../../widgets/concept_list.dart';
import '../../widgets/relationship_list.dart';

@RoutePage()
class VisualizationPage extends StatefulWidget {
  final String documentId;

  const VisualizationPage({
    Key? key,
    @PathParam('documentId') required this.documentId,
  }) : super(key: key);

  @override
  _VisualizationPageState createState() => _VisualizationPageState();
}

class _VisualizationPageState extends State<VisualizationPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Document? _document;
  bool _isLoading = true;
  String _selectedTopic = 'all';
  String _visualizationType = 'mindmap';

  // Mock visualization data
  final Map<String, dynamic> _visualizationData = {
    'nodes': [
      {'id': 'node1', 'label': 'Quantum Physics', 'group': 1},
      {'id': 'node2', 'label': 'Wave-Particle Duality', 'group': 1},
      {'id': 'node3', 'label': 'Quantum Entanglement', 'group': 1},
      {'id': 'node4', 'label': 'Schrödinger\'s Equation', 'group': 2},
      {'id': 'node5', 'label': 'Quantum Computing', 'group': 3},
    ],
    'edges': [
      {'source': 'node1', 'target': 'node2'},
      {'source': 'node1', 'target': 'node3'},
      {'source': 'node2', 'target': 'node4'},
      {'source': 'node3', 'target': 'node5'},
    ],
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadDocument();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _loadDocument() async {
    setState(() {
      _isLoading = true;
    });

    // In a real app, you would fetch the document from your repository
    // For now, we'll simulate a delay and then set a mock document
    await Future.delayed(const Duration(seconds: 1));

    // This would be replaced with actual document fetching logic
    final mockDocument = Document(
      id: widget.documentId,
      name: 'Physics Notes.pdf',
      type: DocumentType.pdf,
      size: '2.4 MB',
      uploadedAt: DateTime.now().subtract(const Duration(days: 2)),
      tags: ['Physics', 'Science', 'Quantum'],
    );

    setState(() {
      _document = mockDocument;
      _isLoading = false;
    });
  }

  void _changeVisualizationType(String type) {
    setState(() {
      _visualizationType = type;
    });
  }

  void _changeTopic(String topic) {
    setState(() {
      _selectedTopic = topic;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_document?.name ?? 'Document Visualization'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // Implement share functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              // Implement download functionality
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                _buildVisualizationControls(),
                Expanded(
                  child: _buildVisualizationContent(),
                ),
              ],
            ),
    );
  }

  Widget _buildVisualizationControls() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Document Visualization',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              SegmentedButton<String>(
                segments: const [
                  ButtonSegment<String>(
                    value: 'mindmap',
                    icon: Icon(Icons.bubble_chart),
                    label: Text('Mind Map'),
                  ),
                  ButtonSegment<String>(
                    value: 'knowledge',
                    icon: Icon(Icons.share),
                    label: Text('Knowledge Graph'),
                  ),
                ],
                selected: {_visualizationType},
                onSelectionChanged: (Set<String> selection) {
                  _changeVisualizationType(selection.first);
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildTopicChip('All Topics', 'all'),
                const SizedBox(width: 8),
                _buildTopicChip('Physics', 'physics'),
                const SizedBox(width: 8),
                _buildTopicChip('Quantum', 'quantum'),
                const SizedBox(width: 8),
                _buildTopicChip('Mechanics', 'mechanics'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopicChip(String label, String value) {
    final isSelected = _selectedTopic == value;
    
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => _changeTopic(value),
      backgroundColor: isSelected ? AppColors.primary.withOpacity(0.1) : null,
      selectedColor: AppColors.primary.withOpacity(0.2),
      checkmarkColor: AppColors.primary,
      labelStyle: TextStyle(
        color: isSelected ? AppColors.primary : null,
        fontWeight: isSelected ? FontWeight.bold : null,
      ),
    );
  }

  Widget _buildVisualizationContent() {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: _visualizationType == 'mindmap'
                  ? MindMapVisualization(data: _visualizationData)
                  : KnowledgeGraphVisualization(data: _visualizationData),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                TabBar(
                  controller: _tabController,
                  tabs: const [
                    Tab(text: 'Key Concepts'),
                    Tab(text: 'Relationships'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      ConceptList(concepts: _visualizationData['nodes']),
                      RelationshipList(
                        nodes: _visualizationData['nodes'],
                        edges: _visualizationData['edges'],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
