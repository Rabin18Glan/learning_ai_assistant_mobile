import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class RelationshipList extends StatelessWidget {
  final List<dynamic> nodes;
  final List<dynamic> edges;

  const RelationshipList({
    Key? key,
    required this.nodes,
    required this.edges,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: edges.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final edge = edges[index];
        final sourceId = edge['source'];
        final targetId = edge['target'];
        
        final sourceNode = _findNode(sourceId);
        final targetNode = _findNode(targetId);
        
        if (sourceNode == null || targetNode == null) {
          return const SizedBox.shrink();
        }
        
        return ListTile(
          title: Row(
            children: [
              Expanded(
                child: Text(
                  sourceNode['label'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const Icon(Icons.arrow_forward, size: 16, color: Colors.grey),
              Expanded(
                child: Text(
                  targetNode['label'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          subtitle: const Center(
            child: Text(
              'relates to',
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
            ),
          ),
          onTap: () {
            // Handle relationship selection
          },
        );
      },
    );
  }

  Map<String, dynamic>? _findNode(String nodeId) {
    try {
      return nodes.firstWhere((node) => node['id'] == nodeId);
    } catch (e) {
      return null;
    }
  }
}
