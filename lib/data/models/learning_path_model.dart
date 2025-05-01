import '../../domain/entities/learning_path.dart';

class LearningPathModel extends LearningPath {
  LearningPathModel({
    required String id,
    required String title,
    required String description,
    required int progress,
    required int totalTopics,
    required int completedTopics,
    required String image,
    required List<String> tags,
  }) : super(
          id: id,
          title: title,
          description: description,
          progress: progress,
          totalTopics: totalTopics,
          completedTopics: completedTopics,
          image: image,
          tags: tags,
        );

  factory LearningPathModel.fromJson(Map<String, dynamic> json) {
    return LearningPathModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      progress: json['progress'],
      totalTopics: json['total_topics'],
      completedTopics: json['completed_topics'],
      image: json['image'],
      tags: List<String>.from(json['tags']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'progress': progress,
      'total_topics': totalTopics,
      'completed_topics': completedTopics,
      'image': image,
      'tags': tags,
    };
  }
}

class QuizModel extends Quiz {
  QuizModel({
    required String id,
    required String title,
    required String description,
    required int questions,
    required String timeLimit,
    required String difficulty,
    bool completed = false,
    int? score,
  }) : super(
          id: id,
          title: title,
          description: description,
          questions: questions,
          timeLimit: timeLimit,
          difficulty: difficulty,
          completed: completed,
          score: score,
        );

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      questions: json['questions'],
      timeLimit: json['time_limit'],
      difficulty: json['difficulty'],
      completed: json['completed'] ?? false,
      score: json['score'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'questions': questions,
      'time_limit': timeLimit,
      'difficulty': difficulty,
      'completed': completed,
      'score': score,
    };
  }
}
