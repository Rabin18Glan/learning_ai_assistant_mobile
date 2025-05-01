import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;
import '../api/api_client.dart';
import '../models/document_model.dart';
import '../../core/error/exceptions.dart';

abstract class DocumentsRemoteDataSource {
  Future<List<DocumentModel>> getDocuments();
  Future<DocumentModel> uploadDocument(File file, String name);
  Future<void> deleteDocument(String id);
  Future<DocumentModel> getDocumentDetails(String id);
}

class DocumentsRemoteDataSourceImpl implements DocumentsRemoteDataSource {
  final ApiClient apiClient;
  final http.Client client;

  DocumentsRemoteDataSourceImpl({
    required this.apiClient,
    required this.client,
  });

@override
  Future<DocumentModel> getDocumentDetails(String id) async {
    try {
      final response = await apiClient.get('/documents/$id');
      return DocumentModel.fromJson(response['document']);
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }



  @override
  Future<List<DocumentModel>> getDocuments() async {
    try {
      final response = await apiClient.get('/documents');
      
      return (response['documents'] as List)
          .map((doc) => DocumentModel.fromJson(doc))
          .toList();
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<DocumentModel> uploadDocument(File file, String name) async {
    try {
      // For file uploads, we need to use a multipart request
      final uri = Uri.parse('${apiClient.baseUrl}/documents/upload');
      
      final request = http.MultipartRequest('POST', uri);
      
      // Add auth headers
      // request.headers.addAll({'Authorization': 'Bearer $token'});
      
      // Add file
      final fileExtension = path.extension(file.path).replaceAll('.', '');
      final mimeType = _getMimeType(fileExtension);
      
      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          file.path,
          contentType: MediaType('application', mimeType),
        ),
      );
      
      // Add document name
      request.fields['name'] = name;
      
      final streamedResponse = await client.send(request);
      final response = await http.Response.fromStream(streamedResponse);
      
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseData = jsonDecode(response.body);
        return DocumentModel.fromJson(responseData['document']);
      } else {
        throw ServerException(
          message: 'Failed to upload document: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> deleteDocument(String id) async {
    try {
      await apiClient.delete('/documents/$id');
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  String _getMimeType(String extension) {
    switch (extension.toLowerCase()) {
      case 'pdf':
        return 'pdf';
      case 'docx':
        return 'vnd.openxmlformats-officedocument.wordprocessingml.document';
      case 'txt':
        return 'plain';
      case 'jpg':
      case 'jpeg':
        return 'jpeg';
      case 'png':
        return 'png';
      default:
        return 'octet-stream';
    }
  }
}
