import 'package:advanced_task_manager/config/config_imports.dart';
import 'package:advanced_task_manager/config/router/router.dart' as router show generateRoute;
import 'package:advanced_task_manager/config/router/router_path.dart';
import 'package:advanced_task_manager/config/theme_data.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      theme: ThemeDataApp.themeData,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: router.generateRoute,
    );
  }
}