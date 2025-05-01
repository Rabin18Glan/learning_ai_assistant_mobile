import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/chat.dart';
import '../../repositories/chat_repository.dart';
import 'package:equatable/equatable.dart';

class CreateNewChatUseCase implements UseCase<ChatSession, CreateNewChatParams> {
  final ChatRepository repository;

  CreateNewChatUseCase(this.repository);

  @override
  Future<Either<Failure, ChatSession>> call(CreateNewChatParams params) async {
    return await repository.createChat(
       params.title,
       params.documentIds,
    );
  }
}

class CreateNewChatParams extends Equatable {
  final String title;
  final List<String> documentIds;

  const CreateNewChatParams({
    required this.title,
    required this.documentIds,
  });

  @override
  List<Object?> get props => [title, documentIds];
}
