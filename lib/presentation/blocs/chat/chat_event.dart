part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class GetChatSessionsEvent extends ChatEvent {}

class GetChatByIdEvent extends ChatEvent {
  final String chatId;

  const GetChatByIdEvent({required this.chatId});

  @override
  List<Object> get props => [chatId];
}

class SendMessageEvent extends ChatEvent {
  final String chatId;
  final String content;
  final List<String> documentIds;

  const SendMessageEvent({
    required this.chatId,
    required this.content,
    this.documentIds = const [],
  });

  @override
  List<Object> get props => [chatId, content, documentIds];
}

class GetChatHistoryEvent extends ChatEvent {
  final String chatId;

  const GetChatHistoryEvent({required this.chatId});

  @override
  List<Object> get props => [chatId];
}
