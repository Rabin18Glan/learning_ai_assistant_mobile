class LearningPath {
  final String id;
  final String title;
  final String description;
  final int progress;
  final int totalTopics;
  final int completedTopics;
  final String image;
  final List<String> tags;

  LearningPath({
    required this.id,
    required this.title,
    required this.description,
    required this.progress,
    required this.totalTopics,
    required this.completedTopics,
    required this.image,
    required this.tags,
  });
}

class Quiz {
  final String id;
  final String title;
  final String description;
  final int questions;
  final String timeLimit;
  final String difficulty;
  final bool completed;
  final int? score;

  Quiz({
    required this.id,
    required this.title,
    required this.description,
    required this.questions,
    required this.timeLimit,
    required this.difficulty,
    this.completed = false,
    this.score,
  });
}
