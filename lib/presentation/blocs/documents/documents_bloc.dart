import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:io';
import '../../../domain/entities/document.dart';
import '../../../domain/usecases/documents/get_documents_usecase.dart';
import '../../../domain/usecases/documents/upload_document_usecase.dart';

part 'documents_event.dart';
part 'documents_state.dart';

class DocumentsBloc extends Bloc<DocumentsEvent, DocumentsState> {
  final GetDocumentsUseCase getDocumentsUseCase;
  final UploadDocumentUseCase uploadDocumentUseCase;

  DocumentsBloc({
    required this.getDocumentsUseCase,
    required this.uploadDocumentUseCase,
  }) : super(DocumentsInitial()) {
    on<GetDocumentsEvent>(_onGetDocuments);
    on<UploadDocumentEvent>(_onUploadDocument);
    on<FilterDocumentsEvent>(_onFilterDocuments);
    on<SearchDocumentsEvent>(_onSearchDocuments);
    on<DeleteDocumentEvent>(_onDeleteDocument);
  }

  Future<void> _onGetDocuments(
    GetDocumentsEvent event,
    Emitter<DocumentsState> emit,
  ) async {
    emit(DocumentsLoading());
    final result = await getDocumentsUseCase();
    result.fold(
      (failure) => emit(DocumentsError(message: failure.toString())),
      (documents) => emit(DocumentsLoaded(documents: documents)),
    );
  }

  Future<void> _onUploadDocument(
    UploadDocumentEvent event,
    Emitter<DocumentsState> emit,
  ) async {
    emit(DocumentUploading());
    final result = await uploadDocumentUseCase(
      UploadDocumentParams(file: event.file, name: event.name),
    );
    result.fold(
      (failure) => emit(DocumentsError(message: failure.toString())),
      (document) {
        if (state is DocumentsLoaded) {
          final currentDocuments = (state as DocumentsLoaded).documents;
          emit(DocumentsLoaded(documents: [...currentDocuments, document]));
        } else {
          emit(DocumentUploadSuccess(document: document));
          add(GetDocumentsEvent());
        }
      },
    );
  }

  Future<void> _onFilterDocuments(
    FilterDocumentsEvent event,
    Emitter<DocumentsState> emit,
  ) async {
    if (state is DocumentsLoaded) {
      final filteredDocuments =
          (state as DocumentsLoaded).documents.where((doc) {
        return event.documentType == null || doc.type == event.documentType;
      }).toList();
      emit(DocumentsLoaded(documents: filteredDocuments));
    }
  }

  Future<void> _onSearchDocuments(
    SearchDocumentsEvent event,
    Emitter<DocumentsState> emit,
  ) async {
    if (state is DocumentsLoaded) {
      final searchedDocuments =
          (state as DocumentsLoaded).documents.where((doc) {
        return doc.name.toLowerCase().contains(event.query.toLowerCase());
      }).toList();
      emit(DocumentsLoaded(documents: searchedDocuments));
    }
  }

  Future<void> _onDeleteDocument(
    DeleteDocumentEvent event,
    Emitter<DocumentsState> emit,
  ) async {
    if (state is DocumentsLoaded) {
      final updatedDocuments =
          (state as DocumentsLoaded).documents.where((doc) {
        return doc.id != event.documentId;
      }).toList();
      emit(DocumentsLoaded(documents: updatedDocuments));
    }
  }
}
