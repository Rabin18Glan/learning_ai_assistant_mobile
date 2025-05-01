import '../pages/analytics/analytics_page.dart';
import '../pages/auth/login_page.dart';
import '../pages/auth/register_page.dart';
import '../pages/chat/chat_detail_page.dart';
import '../pages/chat/chat_list_page.dart';
import '../pages/chat/new_chat_page.dart';
import '../pages/dashboard/dashboard_page.dart';
import '../pages/documents/documents_page.dart';
import '../pages/learning/learning_page.dart';
import '../pages/main/main_page.dart';
import '../pages/settings/settings_page.dart';
import '../pages/splash/splash_page.dart';
import '../pages/visualization/visualization_page.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String main = '/main';
  static const String dashboard = '/dashboard';
  static const String documents = '/documents';
  static const String chatList = '/chatList';
  static const String chatDetail = '/chatDetail';
  static const String newChat = '/newChat';
  static const String learning = '/learning';
  static const String analytics = '/analytics';
  static const String settings = '/settings';
  static const String uploadDocument = '/uploadDocument';
  static const String visualization = '/visualization';

  static Route<dynamic> generateRoute(RouteSettings setting) {
    switch (setting.name) {
      case splash:
        return MaterialPageRoute(builder: (_) =>const SplashPage());
      case login:
        return MaterialPageRoute(builder: (_) =>const LoginPage());
      case register:
        return MaterialPageRoute(builder: (_) =>const RegisterPage());
      case main:
        return MaterialPageRoute(builder: (_) =>const MainPage());
      case dashboard:
        return MaterialPageRoute(builder: (_) =>const DashboardPage());
      case documents:
        return MaterialPageRoute(builder: (_) =>const DocumentsPage());
      case chatList:
        return MaterialPageRoute(builder: (_) =>const ChatListPage());
      case chatDetail:
        final args = setting.arguments as Map<String, dynamic>;
        final chatId = args['chatId'] as String;
        return MaterialPageRoute(
            builder: (_) => ChatDetailPage(chatId: chatId));
      case newChat:
        return MaterialPageRoute(builder: (_) =>const NewChatPage());
      case learning:
        return MaterialPageRoute(builder: (_) =>const LearningPage());
      case analytics:
        return MaterialPageRoute(builder: (_) =>const AnalyticsPage());
      case settings:
        return MaterialPageRoute(builder: (_) =>const SettingsPage());
      case uploadDocument:
        return MaterialPageRoute(builder: (_) =>const DocumentsPage());
      case visualization:
        final args = setting.arguments as Map<String, dynamic>;
        final documentId = args['documentId'] as String;
        return MaterialPageRoute(
            builder: (_) => VisualizationPage(
                  documentId: documentId,
                ));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${setting.name}')),
                ));
    }
  }
}
