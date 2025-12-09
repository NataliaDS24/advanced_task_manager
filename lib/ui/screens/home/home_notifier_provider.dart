import 'package:advanced_task_manager/ui/screens/home/home_notifier.dart';
import 'package:flutter_riverpod/legacy.dart';

final taskNotifierProvider =
    StateNotifierProvider<HomeNotifier, HomeStateNotifier>((ref) {
  return HomeNotifier(ref);
});
