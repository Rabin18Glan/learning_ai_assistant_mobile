part of 'documents_bloc.dart';

abstract class DocumentsState extends Equatable {
  const DocumentsState();
  
  @override
  List<Object?> get props => [];
}

class DocumentsInitial extends DocumentsState {}

class DocumentsLoading extends DocumentsState {}

class DocumentsLoaded extends DocumentsState {
  final List<Document> documents;

  const DocumentsLoaded({required this.documents});

  @override
  List<Object> get props => [documents];
}

class DocumentUploading extends DocumentsState {}

class DocumentUploadSuccess extends DocumentsState {
  final Document document;

  const DocumentUploadSuccess({required this.document});

  @override
  List<Object> get props => [document];
}

class DocumentsError extends DocumentsState {
  final String message;

  const DocumentsError({required this.message});

  @override
  List<Object> get props => [message];
}
