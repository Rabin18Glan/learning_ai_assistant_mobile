import 'chat_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import '../../blocs/chat/chat_bloc.dart'; // Parent file for chat_event and chat_state
import '../../blocs/documents/documents_bloc.dart'; // Parent file for documents_event and documents_state

import '../../widgets/document_selection_tile.dart';

@RoutePage()
class NewChatPage extends StatefulWidget {
  const NewChatPage({Key? key}) : super(key: key);

  @override
  State<NewChatPage> createState() => _NewChatPageState();
}

class _NewChatPageState extends State<NewChatPage> {
  final TextEditingController _chatNameController = TextEditingController();
  final Set<String> _selectedDocumentIds = {};
  
  @override
  void initState() {
    super.initState();
    _loadDocuments();
  }
  
  void _loadDocuments() {
    context.read<DocumentsBloc>().add(GetDocumentsEvent());
  }
  
  void _toggleDocumentSelection(String documentId) {
    setState(() {
      if (_selectedDocumentIds.contains(documentId)) {
        _selectedDocumentIds.remove(documentId);
      } else {
        _selectedDocumentIds.add(documentId);
      }
    });
  }
  
  void _createNewChat() {
    if (_chatNameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a chat name')),
      );
      return;
    }
    
    if (_selectedDocumentIds.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one document')),
      );
      return;
    }
    
    context.read<ChatBloc>().add(
      SendMessageEvent(
        chatId: '', // Placeholder for chat ID
        content: _chatNameController.text.trim(),
        documentIds: _selectedDocumentIds.toList(),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Chat'),
      ),
      body: BlocListener<ChatBloc, ChatState>(
        listener: (context, state) {
          if (state is ChatDetailLoaded) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatDetailPage(chatId: state.chatSession.id),
              ),
            );
          } else if (state is ChatErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.message}')),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Chat name input
              TextField(
                controller: _chatNameController,
                decoration: InputDecoration(
                  labelText: 'Chat Name',
                  hintText: 'Enter a name for your chat',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.chat),
                ),
              ),
              const SizedBox(height: 24),
              
              // Document selection section
              Text(
                'Select Documents',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Choose documents to include in this chat',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 16),
              
              // Document list
              Expanded(
                child: BlocBuilder<DocumentsBloc, DocumentsState>(
                  builder: (context, state) {
                    if (state is DocumentsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is DocumentsError) {
                      return Center(child: Text('Error: ${state.message}'));
                    } else if (state is DocumentsLoaded) {
                      if (state.documents.isEmpty) {
                        return const Center(
                          child: Text('No documents available'),
                        );
                      }
                      
                      return ListView.builder(
                        itemCount: state.documents.length,
                        itemBuilder: (context, index) {
                          final document = state.documents[index];
                          final isSelected = _selectedDocumentIds.contains(document.id);
                          
                          return DocumentSelectionTile(
                            document: document,
                            isSelected: isSelected,
                            onToggle: () => _toggleDocumentSelection(document.id),
                          );
                        },
                      );
                    }
                    
                    return const Center(child: Text('No documents available'));
                  },
                ),
              ),
              
              // Create chat button
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _createNewChat,
                  child: const Text('Create Chat'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  @override
  void dispose() {
    _chatNameController.dispose();
    super.dispose();
  }
}
