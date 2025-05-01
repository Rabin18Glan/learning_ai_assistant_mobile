import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/chat.dart' as chat_entities;
import '../../../domain/entities/chat.dart' show MessageRole;
import '../../../domain/entities/document.dart' as document_entities;
import '../../blocs/chat/chat_bloc.dart';
import '../../widgets/chat_message_bubble.dart';
import '../../widgets/document_sidebar.dart';
import '../../widgets/gradient_button.dart';

@RoutePage()
class ChatDetailPage extends StatefulWidget {
  final String chatId;

  const ChatDetailPage({Key? key, @PathParam('id') required this.chatId})
      : super(key: key);

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isDocumentSidebarOpen = false;

  @override
  void initState() {
    super.initState();
    _loadChatHistory();
  }

  void _loadChatHistory() {
    context.read<ChatBloc>().add(GetChatHistoryEvent(chatId: widget.chatId));
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    context.read<ChatBloc>().add(
          SendMessageEvent(
            chatId: widget.chatId,
            content: _messageController.text.trim(),
          ),
        );

    _messageController.clear();

    // Scroll to bottom after message is sent
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _toggleDocumentSidebar() {
    setState(() {
      _isDocumentSidebarOpen = !_isDocumentSidebarOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu_book),
            onPressed: _toggleDocumentSidebar,
            tooltip: 'View Related Documents',
          ),
        ],
      ),
      body: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {
          if (state is ChatMessageSentState) {
            // Scroll to bottom when a new message is sent
            Future.delayed(const Duration(milliseconds: 100), () {
              if (_scrollController.hasClients) {
                _scrollController.animateTo(
                  _scrollController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              }
            });
          }
        },
        builder: (context, state) {
          if (state is ChatLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ChatErrorState) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is ChatHistoryLoadedState ||
              state is ChatMessageSentState) {
            final chat_entities.ChatSession? chat = state is ChatHistoryLoadedState
                ? state.chat
                : (state as ChatMessageSentState).chat;

            if (chat == null) {
              return const Center(child: Text('Chat not found'));
            }

            return Row(
              children: [
                // Main chat area
                Expanded(
                  child: Column(
                    children: [
                      // Chat messages
                      Expanded(
                        child: chat.messages.isEmpty
                            ? const Center(
                                child: Text(
                                  'No messages yet. Start the conversation!',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              )
                            : ListView.builder(
                                controller: _scrollController,
                                padding: const EdgeInsets.all(16),
                                itemCount: chat.messages.length,
                                itemBuilder: (context, index) {
                                  final message = chat.messages[index];
                                  return ChatMessageBubble(
                                    message: message,
                                    isUser: message.role == MessageRole.user,
                                  );
                                },
                              ),
                      ),

                      // Message input
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 5,
                              offset: const Offset(0, -2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.mic),
                              onPressed: () {
                                // TODO: Implement voice input
                              },
                              tooltip: 'Voice Input',
                            ),
                            Expanded(
                              child: TextField(
                                controller: _messageController,
                                decoration: InputDecoration(
                                  hintText: 'Type your message...',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(24),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.grey[200]
                                      : Colors.grey[800],
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                ),
                                textInputAction: TextInputAction.send,
                                onSubmitted: (_) => _sendMessage(),
                              ),
                            ),
                            const SizedBox(width: 8),
                            // Fix GradientButton usage
                            GradientButton(
                              text: '', // Provide appropriate text here
                              onPressed: _sendMessage,
                              width: 48,
                              height: 48,
                              borderRadius: 24,
                            gradientColors:const  [
                                  AppColors.primaryGradientStart,
                                  AppColors.primaryGradientEnd
                                ],
                              
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Document sidebar
                if (_isDocumentSidebarOpen)
                  DocumentSidebar(
                    documents: <document_entities.Document>[],
                    onClose: _toggleDocumentSidebar,
                  ),
              ],
            );
          }

          return const Center(child: Text('Start a conversation'));
        },
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
