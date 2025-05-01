import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../repositories/chat_repository.dart';
import 'package:equatable/equatable.dart';

// class DeleteChatUseCase implements UseCase<bool, DeleteChatParams> {
//   final ChatRepository repository;

//   DeleteChatUseCase(this.repository);

//   @override
//   Future<Either<Failure, bool>> call(DeleteChatParams params) async {
//     return await repository.deleteChat(params.chatId);
//   }
// }

class DeleteChatParams extends Equatable {
  final String chatId;

  const DeleteChatParams({required this.chatId});

  @override
  List<Object?> get props => [chatId];
}
