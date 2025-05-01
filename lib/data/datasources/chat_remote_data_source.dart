import '../api/api_client.dart';
import '../models/chat_model.dart';
import '../../core/error/exceptions.dart';

abstract class ChatRemoteDataSource {
  Future<List<ChatSessionModel>> getChatSessions();
  Future<ChatSessionModel> getChatById(String chatId);
  Future<MessageModel> sendMessage(String chatId, String content, List<String> documentIds);
  Future<ChatSessionModel> createChat(String title, List<String> documentIds);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final ApiClient apiClient;

  ChatRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<ChatSessionModel>> getChatSessions() async {
    try {
      final response = await apiClient.get('/chats');
      
      return (response['chat_sessions'] as List)
          .map((chat) => ChatSessionModel.fromJson(chat))
          .toList();
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<ChatSessionModel> getChatById(String chatId) async {
    try {
      final response = await apiClient.get('/chats/$chatId');
      
      return ChatSessionModel.fromJson(response['chat_session']);
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<MessageModel> sendMessage(String chatId, String content, List<String> documentIds) async {
    try {
      final response = await apiClient.post(
        '/chats/$chatId/messages',
        body: {
          'content': content,
          'document_ids': documentIds,
        },
      );
      
      return MessageModel.fromJson(response['message']);
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<ChatSessionModel> createChat(String title, List<String> documentIds) async {
    try {
      final response = await apiClient.post(
        '/chats',
        body: {
          'title': title,
          'document_ids': documentIds,
        },
      );
      
      return ChatSessionModel.fromJson(response['chat_session']);
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
