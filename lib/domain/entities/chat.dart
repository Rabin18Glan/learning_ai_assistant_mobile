enum MessageRole { user, assistant }

class Message {
  final String id;
  final MessageRole role;
  final String content;
  final DateTime timestamp;

  Message({
    required this.id,
    required this.role,
    required this.content,
    required this.timestamp,
  });
}

class ChatSession {
  final String id;
  final String title;
  final String preview;
  final DateTime timestamp;
  final String? documentName;
  final List<Message> messages;

  ChatSession({
    required this.id,
    required this.title,
    required this.preview,
    required this.timestamp,
    this.documentName,
    this.messages = const [],
  });
}
