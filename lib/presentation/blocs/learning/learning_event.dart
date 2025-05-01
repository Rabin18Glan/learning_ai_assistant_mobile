part of 'learning_bloc.dart';

abstract class LearningEvent extends Equatable {
  const LearningEvent();

  @override
  List<Object> get props => [];
}

class GetLearningPathsEvent extends LearningEvent {}

class GetQuizzesEvent extends LearningEvent {}
