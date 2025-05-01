import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_colors.dart';
import '../../../domain/entities/learning_path.dart';
import '../../blocs/learning/learning_bloc.dart';
import '../../widgets/learning_path_card.dart';
import '../../widgets/quiz_card.dart';
import '../../widgets/empty_state.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

@RoutePage()
class LearningPage extends StatefulWidget {
  const LearningPage({Key? key}) : super(key: key);

  @override
  _LearningPageState createState() => _LearningPageState();
}

class _LearningPageState extends State<LearningPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadData();
  }

  void _loadData() {
    context.read<LearningBloc>().add(GetLearningPathsEvent());
    context.read<LearningBloc>().add(GetQuizzesEvent());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learning'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Learning Paths'),
            Tab(text: 'Quizzes'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildLearningPathsTab(),
          _buildQuizzesTab(),
        ],
      ),
    );
  }

  Widget _buildLearningPathsTab() {
    return BlocBuilder<LearningBloc, LearningState>(
      builder: (context, state) {
        if (state is LearningLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is LearningPathsLoaded) {
          final learningPaths = state.learningPaths;

          if (learningPaths.isEmpty) {
            return EmptyState(
              icon: Icons.school,
              title: 'No learning paths yet',
              description:
                  "Create your first learning path to start your educational journey",
              // message: 'Create your first learning path to start your educational journey',
              buttonText: 'Create Learning Path',
              onButtonPressed: () {
                // Navigate to create learning path
              },
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLearningStats(learningPaths),
                const SizedBox(height: 24),
                Text(
                  'Your Learning Paths',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: learningPaths.length,
                  itemBuilder: (context, index) {
                    return LearningPathCard(
                      learningPath: learningPaths[index],
                      onTap: () {
                        // Navigate to learning path detail
                      },
                    );
                  },
                ),
              ],
            ),
          );
        } else if (state is LearningError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  color: AppColors.error,
                  size: 60,
                ),
                const SizedBox(height: 16),
                Text(
                  'Error loading learning paths',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(state.message),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () =>
                      context.read<LearningBloc>().add(GetLearningPathsEvent()),
                  child: const Text('Try Again'),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildQuizzesTab() {
    return BlocBuilder<LearningBloc, LearningState>(
      builder: (context, state) {
        if (state is LearningLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is QuizzesLoaded) {
          final quizzes = state.quizzes;

          if (quizzes.isEmpty) {
            return EmptyState(
              icon: Icons.quiz,
              title: 'No quizzes yet',
              description: 'Create your first quiz to test your knowledge',
              buttonText: 'Create Quiz',
              onButtonPressed: () {
                // Navigate to create quiz
              },
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: quizzes.length,
            itemBuilder: (context, index) {
              return QuizCard(
                quiz: quizzes[index],
                onTap: () {
                  // Navigate to quiz detail
                },
              );
            },
          );
        } else if (state is LearningError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  color: AppColors.error,
                  size: 60,
                ),
                const SizedBox(height: 16),
                Text(
                  'Error loading quizzes',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(state.message),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () =>
                      context.read<LearningBloc>().add(GetQuizzesEvent()),
                  child: const Text('Try Again'),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildLearningStats(List<LearningPath> learningPaths) {
    // Calculate total progress
    int totalCompleted = 0;
    int totalTopics = 0;
    for (final path in learningPaths) {
      totalCompleted += path.completedTopics;
      totalTopics += path.totalTopics;
    }

    final overallProgress =
        totalTopics > 0 ? (totalCompleted / totalTopics * 100).round() : 0;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircularPercentIndicator(
              radius: 40,
              lineWidth: 8,
              percent: overallProgress / 100,
              center: Text(
                '$overallProgress%',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              progressColor: AppColors.primary,
              backgroundColor: AppColors.primary.withOpacity(0.2),
              circularStrokeCap: CircularStrokeCap.round,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Overall Progress',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$totalCompleted of $totalTopics topics completed',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodySmall?.color,
                    ),
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: overallProgress / 100,
                    backgroundColor: AppColors.primary.withOpacity(0.2),
                    valueColor:
                        AlwaysStoppedAnimation<Color>(AppColors.primary),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
