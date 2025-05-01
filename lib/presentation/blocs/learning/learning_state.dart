part of 'learning_bloc.dart';

abstract class LearningState extends Equatable {
  const LearningState();
  
  @override
  List<Object?> get props => [];
}

class LearningInitial extends LearningState {}

class LearningLoading extends LearningState {}

class LearningPathsLoaded extends LearningState {
  final List<LearningPath> learningPaths;

  const LearningPathsLoaded({required this.learningPaths});

  @override
  List<Object> get props => [learningPaths];
}

class QuizzesLoaded extends LearningState {
  final List<Quiz> quizzes;

  const QuizzesLoaded({required this.quizzes});

  @override
  List<Object> get props => [quizzes];
}

class LearningError extends LearningState {
  final String message;

  const LearningError({required this.message});

  @override
  List<Object> get props => [message];
}
