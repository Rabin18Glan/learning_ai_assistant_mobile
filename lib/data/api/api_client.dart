import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/error/exceptions.dart';

class ApiClient {
  final http.Client client;
  final String baseUrl;
  final Map<String, String> defaultHeaders;

  ApiClient({
    required this.client,
    required this.baseUrl,
    this.defaultHeaders = const {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  });

  Future<dynamic> get(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint').replace(
        queryParameters: queryParams,
      );
      
      final response = await client.get(
        uri,
        headers: {...defaultHeaders, ...?headers},
      ).timeout(const Duration(seconds: 30));

      return _processResponse(response);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<dynamic> post(
    String endpoint, {
    Map<String, String>? headers,
    dynamic body,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');
      
      final response = await client.post(
        uri,
        headers: {...defaultHeaders, ...?headers},
        body: body != null ? json.encode(body) : null,
      ).timeout(const Duration(seconds: 30));

      return _processResponse(response);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<dynamic> put(
    String endpoint, {
    Map<String, String>? headers,
    dynamic body,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');
      
      final response = await client.put(
        uri,
        headers: {...defaultHeaders, ...?headers},
        body: body != null ? json.encode(body) : null,
      ).timeout(const Duration(seconds: 30));

      return _processResponse(response);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<dynamic> delete(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');
      
      final response = await client.delete(
        uri,
        headers: {...defaultHeaders, ...?headers},
      ).timeout(const Duration(seconds: 30));

      return _processResponse(response);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  dynamic _processResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return null;
      return json.decode(response.body);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else if (response.statusCode == 404) {
      throw NotFoundException();
    } else {
      throw ServerException(
        message: 'Server error with status code: ${response.statusCode}',
      );
    }
  }
}
