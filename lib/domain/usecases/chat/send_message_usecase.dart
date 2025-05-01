import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/chat.dart';
import '../../repositories/chat_repository.dart';

class SendMessageUseCase implements UseCase<Message, SendMessageParams> {
  final ChatRepository repository;

  SendMessageUseCase(this.repository);

  @override
  Future<Either<Failure, Message>> call(SendMessageParams params) async {
    return await repository.sendMessage(
      params.chatId,
      params.content,
      params.documentIds,
    );
  }
}

class SendMessageParams extends Equatable {
  final String chatId;
  final String content;
  final List<String> documentIds;

  const SendMessageParams({
    required this.chatId,
    required this.content,
    this.documentIds = const [],
  });

  @override
  List<Object> get props => [chatId, content, documentIds];
}
