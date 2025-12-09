import 'package:advanced_task_manager/config/config_imports.dart';
import 'package:advanced_task_manager/config/router/router_path.dart';
import 'package:advanced_task_manager/ui/screens/splash/splash_notifier_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(splashNotifierProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state.isReady) {
        Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.homeListTasks,
        (route) => false,
        );
      }
    });

    return Scaffold(
      body: Center(
        child: state.isLoading
            ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppStrings.appName,
                  style: AppTextStyles.primaryInterBold40,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                const CircularProgressIndicator(),
              ],
            )
            : state.isError
                ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Error: ${state.errorMessage}"),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () {
                            ref.read(splashNotifierProvider.notifier).initializeApp();
                          },
                          child: const Text("Reintentar"),
                        )
                      ],
                    ),
                )
                : const SizedBox.shrink(),
      ),
    );
  }
}
