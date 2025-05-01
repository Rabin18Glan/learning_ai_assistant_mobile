enum DocumentType { pdf, docx, txt, image }

class Document {
  final String id;
  final String name;
  final DocumentType type;
  final String size;
  final DateTime uploadedAt;
  final List<String> tags;
  final String? thumbnail;

  Document({
    required this.id,
    required this.name,
    required this.type,
    required this.size,
    required this.uploadedAt,
    required this.tags,
    this.thumbnail,
  });
}
