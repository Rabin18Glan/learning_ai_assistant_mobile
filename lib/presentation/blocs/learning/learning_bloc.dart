import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/learning_path.dart';
import '../../../domain/usecases/learning/get_learning_paths_usecase.dart';

part 'learning_event.dart';
part 'learning_state.dart';

class LearningBloc extends Bloc<LearningEvent, LearningState> {
  final GetLearningPathsUseCase getLearningPathsUseCase;

  LearningBloc({
    required this.getLearningPathsUseCase,
  }) : super(LearningInitial()) {
    on<GetLearningPathsEvent>(_onGetLearningPaths);
    on<GetQuizzesEvent>(_onGetQuizzes);
  }

  Future<void> _onGetLearningPaths(
    GetLearningPathsEvent event,
    Emitter<LearningState> emit,
  ) async {
    emit(LearningLoading());
    final result = await getLearningPathsUseCase();
    result.fold(
      (failure) => emit(LearningError(message: failure.toString())),
      (learningPaths) =>
          emit(LearningPathsLoaded(learningPaths: learningPaths)),
    );
  }

  Future<void> _onGetQuizzes(
    GetQuizzesEvent event,
    Emitter<LearningState> emit,
  ) async {
    emit(LearningLoading());
    final result = await getLearningPathsUseCase.getQuizzes();
    result.fold(
      (failure) => emit(LearningError(message: failure.toString())),
      (quizzes) => emit(QuizzesLoaded(quizzes: quizzes)),
    );
  }
}
