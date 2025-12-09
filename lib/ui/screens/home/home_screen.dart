import 'package:advanced_task_manager/config/config_imports.dart';
import 'package:advanced_task_manager/config/router/router_path.dart';
import 'package:advanced_task_manager/enums/task_state.dart';
import 'package:advanced_task_manager/ui/screens/home/home_notifier_provider.dart';
import 'package:advanced_task_manager/ui/widgets/appbar_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeTasksListScreen extends ConsumerWidget {
  const HomeTasksListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(taskNotifierProvider);
    final notifier = ref.read(taskNotifierProvider.notifier);

    return Scaffold(
      appBar: const AppBarHome(),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.tasks.isEmpty
              ? const Center(
                  child: Text(
                    AppStrings.notPhotos,
                    style: AppTextStyles.primaryInterSemiBold20,
                  ),
                )
              : ListView.builder(
                  itemCount: state.tasks.length,
                  itemBuilder: (context, index) {
                    final task = state.tasks[index];
                    return Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: AppColors.grey,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: ListTile(
                        title: Text(
                          task.title, 
                          style: AppTextStyles.blackInterSemiBold15,
                        ),
                        enabled: task.state != TaskState.completed ? true : false,
                        tileColor: task.state != TaskState.completed ? AppColors.lightRed : AppColors.lightGreen,
                        subtitle: Text(
                            "${AppStrings.stateTask} ${task.state.name}${AppStrings.priorityTask} ${task.priority.name}",
                            style: AppTextStyles.blackInterThin10,
                            ),
                        leading: Checkbox(
                          value: task.state == TaskState.completed,
                          onChanged: (_) {
                            notifier.toggleTaskCompleted(task);
                          },
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.taskAction, arguments: task);
                        },
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.taskAction);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
