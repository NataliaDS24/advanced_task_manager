import 'package:advanced_task_manager/ui/screens/splash/splash_notifier.dart';
import 'package:flutter_riverpod/legacy.dart';

final splashNotifierProvider =
      StateNotifierProvider<SplashNotifier, SplashState>((ref) {
    final notifier = SplashNotifier(ref);
    notifier.initializeApp();

    return notifier;
});