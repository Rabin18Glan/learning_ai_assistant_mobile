import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import '../../core/theme/app_colors.dart';

class KnowledgeGraphVisualization extends StatefulWidget {
  final Map<String, dynamic> data;

  const KnowledgeGraphVisualization({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  _KnowledgeGraphVisualizationState createState() =>
      _KnowledgeGraphVisualizationState();
}

class NodeData {
  final String label;
  final Color color;
  final int group;

  NodeData({required this.label, required this.color, required this.group});
}

class _KnowledgeGraphVisualizationState
    extends State<KnowledgeGraphVisualization> {
  late Graph graph;
  late Algorithm algorithm;
  final Map<String, Node> nodeMap = {};
  final Map<String, NodeData> nodeDataMap = {}; // Store node data separately

  @override
  void initState() {
    super.initState();
    _initializeGraph();
  }

  void _initializeGraph() {
    graph = Graph()..isTree = false;

    // Create nodes
    for (var nodeData in widget.data['nodes']) {
      final id = nodeData['id'];
      final group = nodeData['group'] ?? 0;
      final label = nodeData['label'] ?? '';

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

      // Create Node with ID only
      final node = Node.Id(id);
      
      // Store the node data separately
      nodeDataMap[id.toString()] = NodeData(
        label: label,
        color: color,
        group: group,
      );
      
      graph.addNode(node);
      nodeMap[id.toString()] = node;
    }

    // Create edges
    for (var edgeData in widget.data['edges']) {
      final sourceId = edgeData['source'].toString();
      final targetId = edgeData['target'].toString();

      if (nodeMap.containsKey(sourceId) && nodeMap.containsKey(targetId)) {
        graph.addEdge(nodeMap[sourceId]!, nodeMap[targetId]!);
      }
    }

    // Use Force-Directed algorithm
    algorithm = FruchtermanReingoldAlgorithm(
      iterations: 1000,
      attractionRate: 0.2,
      repulsionRate: 0.2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return InteractiveViewer(
          constrained: false,
          boundaryMargin: EdgeInsets.all(100),
          minScale: 0.01,
          maxScale: 5.6,
          child: GraphView(
            graph: graph,
            algorithm: algorithm,
            paint: Paint()
              ..color = AppColors.primary.withOpacity(0.6)
              ..strokeWidth = 1.5
              ..style = PaintingStyle.stroke,
            builder: (Node node) {
              // Get node data from our separate map using node.key
              var nodeId = node.key?.value.toString() ?? '';
              var nodeData = nodeDataMap[nodeId];
              
              if (nodeData == null) {
                // Fallback widget if data isn't found
                return Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                );
              }

              return Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: nodeData.color, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: nodeData.color.withOpacity(0.3),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: nodeWidget(nodeData.label, nodeData.color),
              );
            },
          ),
        );
      },
    );
  }

  Widget nodeWidget(String label, Color color) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: color.withOpacity(0.8),
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

class KnowledgeGraphScreen extends StatelessWidget {
  final Map<String, dynamic> graphData;

  const KnowledgeGraphScreen({
    Key? key,
    required this.graphData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Knowledge Graph'),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),
      body: Column(
        children: [
          _buildLegend(),
          Expanded(
            child: KnowledgeGraphVisualization(
              data: graphData,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Reset view or perform another action
        },
        child: Icon(Icons.refresh),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  Widget _buildLegend() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _legendItem('Main Concepts', AppColors.primary),
          SizedBox(width: 16),
          _legendItem('Related Topics', AppColors.secondary),
          SizedBox(width: 16),
          _legendItem('Examples', AppColors.accent),
        ],
      ),
    );
  }

  Widget _legendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}