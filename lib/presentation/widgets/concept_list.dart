import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class ConceptList extends StatelessWidget {
  final List<dynamic> concepts;

  const ConceptList({
    Key? key,
    required this.concepts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: concepts.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final concept = concepts[index];
        final group = concept['group'] ?? 0;
        
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
        
        // Count connections
        final connections = _countConnections(concept['id']);
        
        return ListTile(
          leading: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          title: Text(
            concept['label'],
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: Text(
            '$connections connections',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
          onTap: () {
            // Handle concept selection
          },
        );
      },
    );
  }

  int _countConnections(String nodeId) {
    // This is a placeholder. In a real app, you would count the actual connections
    // based on the edges data
    return nodeId.hashCode % 5 + 1; // Random number between 1 and 5
  }
}
