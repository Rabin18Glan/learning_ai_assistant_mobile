import 'dart:io';
import 'package:path/path.dart' as path;
import '../documents_remote_data_source.dart';
import '../../models/document_model.dart';
import '../../../domain/entities/document.dart';
import '../../../core/error/exceptions.dart';

class MockDocumentsRemoteDataSource implements DocumentsRemoteDataSource {
  final List<DocumentModel> _documents = [
    DocumentModel(
      id: '1',
      name: 'Physics Notes.pdf',
      type: DocumentType.pdf,
      size: '2.4 MB',
      uploadedAt: DateTime.now().subtract(const Duration(hours: 2)),
      tags: ['Physics', 'Science'],
      thumbnail: null,
    ),
    DocumentModel(
      id: '2',
      name: 'Math Formulas.docx',
      type: DocumentType.docx,
      size: '1.2 MB',
      uploadedAt: DateTime.now().subtract(const Duration(days: 1)),
      tags: ['Math', 'Formulas'],
      thumbnail: null,
    ),
    DocumentModel(
      id: '3',
      name: 'History Timeline.pdf',
      type: DocumentType.pdf,
      size: '3.7 MB',
      uploadedAt: DateTime.now().subtract(const Duration(days: 3)),
      tags: ['History'],
      thumbnail: null,
    ),
  ];

@override
  Future<DocumentModel> getDocumentDetails(String id) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    final document = _documents.firstWhere(
      (doc) => doc.id == id,
      orElse: () => throw NotFoundException(message: 'Document not found'),
    );

    return document;
  }


  @override
  Future<List<DocumentModel>> getDocuments() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    return _documents;
  }

  @override
  Future<DocumentModel> uploadDocument(File file, String name) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    final fileExtension = path.extension(file.path).replaceAll('.', '');
    DocumentType type;
    
    switch (fileExtension.toLowerCase()) {
      case 'pdf':
        type = DocumentType.pdf;
        break;
      case 'docx':
        type = DocumentType.docx;
        break;
      case 'txt':
        type = DocumentType.txt;
        break;
      default:
        type = DocumentType.image;
    }

    final newDocument = DocumentModel(
      id: (_documents.length + 1).toString(),
      name: name,
      type: type,
      size: '${(file.lengthSync() / 1024 / 1024).toStringAsFixed(1)} MB',
      uploadedAt: DateTime.now(),
      tags: [type.toString().split('.').last.toUpperCase()],
      thumbnail: null,
    );

    _documents.add(newDocument);

    return newDocument;
  }

  @override
  Future<void> deleteDocument(String id) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    final documentIndex = _documents.indexWhere((doc) => doc.id == id);
    
    if (documentIndex == -1) {
      throw NotFoundException(message: 'Document not found');
    }

    _documents.removeAt(documentIndex);
  }
}
