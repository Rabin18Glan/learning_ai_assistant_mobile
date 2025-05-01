import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import '../../core/theme/app_colors.dart';
import '../routes/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth/auth_bloc.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tabsRouter = AutoTabsRouter.of(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDarkMode
                ? [
                    AppColors.backgroundDark,
                    Color.lerp(AppColors.backgroundDark,
                        AppColors.primary.withValues(alpha: 0.1), 0.5)!,
                  ]
                : [
                    AppColors.backgroundLight,
                    Color.lerp(AppColors.backgroundLight,
                        AppColors.primary.withValues(alpha: 0.1), 0.5)!,
                  ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: AppColors.primaryGradient,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.book,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'EduSense AI',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()
                          ..shader = const LinearGradient(
                            colors: AppColors.primaryGradient,
                          ).createShader(
                              const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              _buildDrawerItem(
                context,
                icon: Icons.dashboard,
                title: 'Dashboard',
                isSelected: tabsRouter.activeIndex == 0,
                onTap: () {
                  tabsRouter.setActiveIndex(0);
                  Navigator.pop(context);
                },
              ),
              _buildDrawerItem(
                context,
                icon: Icons.description,
                title: 'Documents',
                isSelected: tabsRouter.activeIndex == 1,
                onTap: () {
                  tabsRouter.setActiveIndex(1);
                  Navigator.pop(context);
                },
              ),
              _buildDrawerItem(
                context,
                icon: Icons.chat_bubble,
                title: 'Chat',
                isSelected: tabsRouter.activeIndex == 2,
                onTap: () {
                  tabsRouter.setActiveIndex(2);
                  Navigator.pop(context);
                },
              ),
              _buildDrawerItem(
                context,
                icon: Icons.upload_file,
                title: 'Upload',
                isSelected: false,
                onTap: () {
                  Navigator.pushReplacementNamed(context, AppRouter.documents);
                },
              ),
              _buildDrawerItem(
                context,
                icon: Icons.school,
                title: 'Learning',
                isSelected: tabsRouter.activeIndex == 3,
                onTap: () {
                  tabsRouter.setActiveIndex(3);
                  Navigator.pop(context);
                },
              ),
              _buildDrawerItem(
                context,
                icon: Icons.bar_chart,
                title: 'Analytics',
                isSelected: false,
                onTap: () {
                  Navigator.pushReplacementNamed(context, AppRouter.analytics);
                },
              ),
              _buildDrawerItem(
                context,
                icon: Icons.settings,
                title: 'Settings',
                isSelected: tabsRouter.activeIndex == 4,
                onTap: () {
                  tabsRouter.setActiveIndex(4);
                  Navigator.pop(context);
                },
              ),
              const Spacer(),
              const Divider(),
              _buildDrawerItem(
                context,
                icon: Icons.logout,
                title: 'Logout',
                isSelected: false,
                onTap: () {
                  context.read<AuthBloc>().add(LogoutEvent());
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? AppColors.primary : null,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? AppColors.primary : null,
        ),
      ),
      onTap: onTap,
      selected: isSelected,
      selectedTileColor: isDarkMode
          ? AppColors.primary.withValues(alpha: 0.1)
          : AppColors.primary.withValues(alpha: 0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }
}
