import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/chat.dart';
import '../../repositories/chat_repository.dart';

class GetChatHistoryUseCase implements UseCase<List<ChatSession>, NoParams> {
  final ChatRepository repository;

  GetChatHistoryUseCase(this.repository);

  @override
  Future<Either<Failure, List<ChatSession>>> call([NoParams params = const NoParams()]) async {
    return await repository.getChatSessions();
  }

  Future<Either<Failure, ChatSession>> getChatById(String chatId) async {
    return await repository.getChatById(chatId);
  }
}
