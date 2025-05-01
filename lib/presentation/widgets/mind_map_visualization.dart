import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import '../../core/theme/app_colors.dart';

class MindMapVisualization extends StatefulWidget {
  final Map<String, dynamic> data;

  const MindMapVisualization({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  _MindMapVisualizationState createState() => _MindMapVisualizationState();
}

class _MindMapVisualizationState extends State<MindMapVisualization> {
  late Graph graph;
  late Algorithm algorithm;
  final Map<String, Node> nodes = {};

  @override
  void initState() {
    super.initState();
    _initializeGraph();
  }

  void _initializeGraph() {
    graph = Graph()..isTree = true;

    // Create nodes
    for (final nodeData in widget.data['nodes']) {
      final node = Node.Id(nodeData['id']);
      nodes[nodeData['id']] = node;
    }

    // Add edges
    for (final edgeData in widget.data['edges']) {
      final sourceNode = nodes[edgeData['source']];
      final targetNode = nodes[edgeData['target']];

      if (sourceNode != null && targetNode != null) {
        graph.addEdge(sourceNode, targetNode);
      }
    }

    // Set up the algorithm
    algorithm = BuchheimWalkerAlgorithm(
      BuchheimWalkerConfiguration()
        ..siblingSeparation = 100
        ..levelSeparation = 100
        ..subtreeSeparation = 100
        ..orientation = BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM,
      TreeEdgeRenderer(
        BuchheimWalkerConfiguration(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      constrained: false,
      boundaryMargin: const EdgeInsets.all(100),
      minScale: 0.1,
      maxScale: 2.5,
      child: GraphView(
        graph: graph,
        algorithm: algorithm,
        paint: Paint()
          ..color = Colors.green
          ..strokeWidth = 1
          ..style = PaintingStyle.stroke,
        builder: (Node node) {
          final nodeId = node.key?.value as String;
          final nodeData = widget.data['nodes'].firstWhere(
            (n) => n['id'] == nodeId,
            orElse: () => {'label': 'Unknown', 'group': 0},
          );

          final label = nodeData['label'];
          final group = nodeData['group'] ?? 0;

          // Determine color based on group
          Color color;
          switch (group) {
            case 1:
              color = AppColors.primary;
              break;
            case 2:
              color = AppColors.secondary;
              break;
            case 3:
              color = AppColors.accent;
              break;
            default:
              color = Colors.grey;
          }

          return _buildNodeWidget(label, color);
        },
      ),
    );
  }

  Widget _buildNodeWidget(String label, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color, width: 2),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
      child: Text(
        label,
        style: TextStyle(
          color: color.withOpacity(0.8),
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
