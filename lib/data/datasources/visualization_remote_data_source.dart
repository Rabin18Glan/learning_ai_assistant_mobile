import 'dart:convert';

import '../../core/error/exceptions.dart';
import '../api/api_client.dart';
import '../models/visualization_model.dart';

abstract class VisualizationRemoteDataSource {
  Future<VisualizationModel> generateVisualization({
    required String documentId,
    required String visualizationType,
  });
  Future<List<VisualizationModel>> getVisualizations(String documentId);
}

class VisualizationRemoteDataSourceImpl implements VisualizationRemoteDataSource {
  final ApiClient client;

  VisualizationRemoteDataSourceImpl({required this.client});

  @override
  Future<VisualizationModel> generateVisualization({
    required String documentId,
    required String visualizationType,
  }) async {
    try {
      final response = await client.post(
        '/visualizations',
        body: {
          'document_id': documentId,
          'type': visualizationType,
        },
      );

      if (response.statusCode == 200) {
        return VisualizationModel.fromJson(json.decode(response.body));
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<VisualizationModel>> getVisualizations(String documentId) async {
    try {
      final response = await client.get('/visualizations?document_id=$documentId');

      if (response.statusCode == 200) {
        final List<dynamic> visualizationsJson = json.decode(response.body);
        return visualizationsJson
            .map((json) => VisualizationModel.fromJson(json))
            .toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
