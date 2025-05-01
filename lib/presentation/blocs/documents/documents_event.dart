part of 'documents_bloc.dart';

abstract class DocumentsEvent extends Equatable {
  const DocumentsEvent();

  @override
  List<Object?> get props => [];
}

class GetDocumentsEvent extends DocumentsEvent {}

class UploadDocumentEvent extends DocumentsEvent {
  final File file;
  final String name;

  const UploadDocumentEvent({
    required this.file,
    required this.name,
  });

  @override
  List<Object?> get props => [file, name];
}

class FilterDocumentsEvent extends DocumentsEvent {
  final DocumentType? documentType;

  const FilterDocumentsEvent({this.documentType});

  @override
  List<Object?> get props => [documentType];
}

class SearchDocumentsEvent extends DocumentsEvent {
  final String query;

  const SearchDocumentsEvent({required this.query});

  @override
  List<Object> get props => [query];
}

class DeleteDocumentEvent extends DocumentsEvent {
  final String documentId;

  const DeleteDocumentEvent({required this.documentId});

  @override
  List<Object> get props => [documentId];
}
