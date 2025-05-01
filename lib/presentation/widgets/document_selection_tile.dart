import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../domain/entities/document.dart';
import 'package:timeago/timeago.dart' as timeago;

class DocumentSelectionTile extends StatelessWidget {
  final Document document;
  final bool isSelected;
  final VoidCallback onToggle;

  const DocumentSelectionTile({
    Key? key,
    required this.document,
    required this.isSelected,
    required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      color: isSelected
          ? AppColors.primary.withOpacity(0.1)
          : isDarkMode
              ? Colors.grey[850]
              : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isSelected
            ? const BorderSide(
                color: AppColors.primary,
                width: 2,
              )
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: onToggle,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              // Document icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      _getColorForDocumentType(document.type.toString())[0],
                      _getColorForDocumentType(document.type.toString())[1],
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Icon(
                    _getIconForDocumentType(document.type.toString()),
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              
              // Document info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      document.name,
                      style: theme.textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${document.size} pages • ${_formatFileSize(int.parse(document.size))} • Uploaded ${timeago.format(document.uploadedAt)}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              
              // Selection checkbox
              Checkbox(
                value: isSelected,
                onChanged: (_) => onToggle(),
                activeColor: AppColors.primaryLight,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIconForDocumentType(String type) {
    switch (type.toLowerCase()) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'doc':
      case 'docx':
        return Icons.description;
      case 'ppt':
      case 'pptx':
        return Icons.slideshow;
      case 'xls':
      case 'xlsx':
        return Icons.table_chart;
      case 'txt':
        return Icons.text_snippet;
      default:
        return Icons.insert_drive_file;
    }
  }

  List<Color> _getColorForDocumentType(String type) {
    switch (type.toLowerCase()) {
      case 'pdf':
        return [Colors.red[400]!, Colors.red[700]!];
      case 'doc':
      case 'docx':
        return [Colors.blue[400]!, Colors.blue[700]!];
      case 'ppt':
      case 'pptx':
        return [Colors.orange[400]!, Colors.orange[700]!];
      case 'xls':
      case 'xlsx':
        return [Colors.green[400]!, Colors.green[700]!];
      case 'txt':
        return [Colors.grey[400]!, Colors.grey[700]!];
      default:
        return [Colors.purple[400]!, Colors.purple[700]!];
    }
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }
}
