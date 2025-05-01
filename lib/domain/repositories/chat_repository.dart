import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/chat.dart';

abstract class ChatRepository {
  Future<Either<Failure, List<ChatSession>>> getChatSessions();
  Future<Either<Failure, ChatSession>> getChatById(String chatId);
  Future<Either<Failure, Message>> sendMessage(
      String chatId, String content, List<String> documentIds);
  Future<Either<Failure, ChatSession>> createChat(
      String title, List<String> documentIds);
}
