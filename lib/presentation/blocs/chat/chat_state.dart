part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatSessionsLoaded extends ChatState {
  final List<ChatSession> chatSessions;

  const ChatSessionsLoaded({required this.chatSessions});

  @override
  List<Object> get props => [chatSessions];
}

class ChatDetailLoaded extends ChatState {
  final ChatSession chatSession;
  final bool isLoading;

  const ChatDetailLoaded({
    required this.chatSession,
    this.isLoading = false,
  });

  @override
  List<Object> get props => [chatSession, isLoading];
}

class ChatMessageSentState extends ChatState {
  final ChatSession chat;

  const ChatMessageSentState({required this.chat});

  @override
  List<Object> get props => [chat];
}

class ChatLoadingState extends ChatState {}

class ChatErrorState extends ChatState {
  final String message;

  const ChatErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class ChatHistoryLoadedState extends ChatState {
  final ChatSession chat;

  const ChatHistoryLoadedState({required this.chat});

  @override
  List<Object> get props => [chat];
}
