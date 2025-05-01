import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/chat.dart';
import '../../../domain/usecases/chat/send_message_usecase.dart';
import '../../../domain/usecases/chat/get_chat_history_usecase.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final SendMessageUseCase sendMessageUseCase;
  final GetChatHistoryUseCase getChatHistoryUseCase;

  ChatBloc({
    required this.sendMessageUseCase,
    required this.getChatHistoryUseCase,
  }) : super(ChatInitial()) {
    on<GetChatSessionsEvent>(_onGetChatSessions);
    on<GetChatByIdEvent>(_onGetChatById);
    on<SendMessageEvent>(_onSendMessage);
  }

  Future<void> _onGetChatSessions(
    GetChatSessionsEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoading());
    final result = await getChatHistoryUseCase();
    result.fold(
      (failure) => emit(ChatErrorState(message: failure.toString())),
      (chatSessions) => emit(ChatSessionsLoaded(chatSessions: chatSessions)),
    );
  }

  Future<void> _onGetChatById(
    GetChatByIdEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoading());
    final result = await getChatHistoryUseCase.getChatById(event.chatId);
    result.fold(
      (failure) => emit(ChatErrorState(message: failure.toString())),
      (chatSession) => emit(ChatDetailLoaded(chatSession: chatSession)),
    );
  }

  Future<void> _onSendMessage(
    SendMessageEvent event,
    Emitter<ChatState> emit,
  ) async {
    if (state is ChatDetailLoaded) {
      final currentState = state as ChatDetailLoaded;
      final currentChat = currentState.chatSession;
      
      // Optimistically add user message
      final userMessage = Message(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        role: MessageRole.user,
        content: event.content,
        timestamp: DateTime.now(),
      );
      
      final updatedMessages = [...currentChat.messages, userMessage];
      emit(ChatDetailLoaded(
        chatSession: ChatSession(
          id: currentChat.id,
          title: currentChat.title,
          preview: currentChat.preview,
          timestamp: currentChat.timestamp,
          documentName: currentChat.documentName,
          messages: updatedMessages,
        ),
        isLoading: true,
      ));

      // Send message to API
      final result = await sendMessageUseCase(
        SendMessageParams(
          chatId: event.chatId,
          content: event.content,
          documentIds: event.documentIds,
        ),
      );

      result.fold(
        (failure) => emit(ChatErrorState(message: failure.toString())),
        (responseMessage) {
          final allMessages = [...updatedMessages, responseMessage];
          emit(ChatDetailLoaded(
            chatSession: ChatSession(
              id: currentChat.id,
              title: currentChat.title,
              preview: currentChat.preview,
              timestamp: DateTime.now(),
              documentName: currentChat.documentName,
              messages: allMessages,
            ),
          ));
        },
      );
    }
  }
}
