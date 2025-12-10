import 'package:advanced_task_manager/config/config_imports.dart';
import 'package:advanced_task_manager/config/router/router_path.dart' show AppRoutes;
import 'package:advanced_task_manager/models/task_model.dart';
import 'package:advanced_task_manager/ui/screens/splash/splash_screen.dart';
import 'package:advanced_task_manager/ui/screens/task_action/task_action_screen.dart';
import 'package:advanced_task_manager/ui/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.splash:
      return _buildRoute(
        settings: settings,
        builder: const SplashScreen(),
      );
    case AppRoutes.homeListTasks:
      return _buildRoute(
        settings: settings,
        builder: const BottomNavigationApp(),
      );
    case AppRoutes.taskAction:
      final args = settings.arguments;
      TaskModel? task;
      if (args != null && args is TaskModel) {
        task = args;
      }
      return _buildRoute(
        settings: settings,
        builder: TaskFormScreen(task: task),
      );
    default:
      return _errorRoute();
  }
}

MaterialPageRoute _buildRoute({
  required RouteSettings settings,
  required Widget builder,
}) {
  return MaterialPageRoute(
    settings: settings,
    maintainState: true,
    builder: (_) => AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: AppColors.primary,
      ),
      child: builder,
    ),
  );
}

// Route for the case where the route was not found
Route<dynamic> _errorRoute() {
  return MaterialPageRoute(
    builder: (context) {
      return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          title: const Text(
            AppStrings.pathError,
          ),
        ),
        body: const Center(
          child: Text(
            AppStrings.pathError,
          ),
        ),
      );
    },
  );
}
