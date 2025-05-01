import '../../domain/entities/chat.dart';

class MessageModel extends Message {
  MessageModel({
    required String id,
    required MessageRole role,
    required String content,
    required DateTime timestamp,
  }) : super(
          id: id,
          role: role,
          content: content,
          timestamp: timestamp,
        );

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      role: json['role'] == 'user' ? MessageRole.user : MessageRole.assistant,
      content: json['content'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'role': role == MessageRole.user ? 'user' : 'assistant',
      'content': content,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}

class ChatSessionModel extends ChatSession {
  ChatSessionModel({
    required String id,
    required String title,
    required String preview,
    required DateTime timestamp,
    String? documentName,
    List<Message> messages = const [],
  }) : super(
          id: id,
          title: title,
          preview: preview,
          timestamp: timestamp,
          documentName: documentName,
          messages: messages,
        );

  factory ChatSessionModel.fromJson(Map<String, dynamic> json) {
    return ChatSessionModel(
      id: json['id'],
      title: json['title'],
      preview: json['preview'],
      timestamp: DateTime.parse(json['timestamp']),
      documentName: json['document_name'],
      messages: json['messages'] != null
          ? List<MessageModel>.from(
              json['messages'].map((m) => MessageModel.fromJson(m)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'preview': preview,
      'timestamp': timestamp.toIso8601String(),
      'document_name': documentName,
      'messages': messages
          .map((m) => (m as MessageModel).toJson())
          .toList(),
    };
  }
}
