import '../../domain/entities/document.dart';

class DocumentModel extends Document {
  DocumentModel({
    required String id,
    required String name,
    required DocumentType type,
    required String size,
    required DateTime uploadedAt,
    required List<String> tags,
    String? thumbnail,
  }) : super(
          id: id,
          name: name,
          type: type,
          size: size,
          uploadedAt: uploadedAt,
          tags: tags,
          thumbnail: thumbnail,
        );

  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    return DocumentModel(
      id: json['id'],
      name: json['name'],
      type: _parseDocumentType(json['type']),
      size: json['size'],
      uploadedAt: DateTime.parse(json['uploaded_at']),
      tags: List<String>.from(json['tags']),
      thumbnail: json['thumbnail'],
    );
  }

  static DocumentType _parseDocumentType(String type) {
    switch (type.toLowerCase()) {
      case 'pdf':
        return DocumentType.pdf;
      case 'docx':
        return DocumentType.docx;
      case 'txt':
        return DocumentType.txt;
      case 'image':
        return DocumentType.image;
      default:
        return DocumentType.pdf;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type.toString().split('.').last,
      'size': size,
      'uploaded_at': uploadedAt.toIso8601String(),
      'tags': tags,
      'thumbnail': thumbnail,
    };
  }
}
