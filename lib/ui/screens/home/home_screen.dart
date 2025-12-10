import 'package:advanced_task_manager/config/config_imports.dart';
import 'package:advanced_task_manager/config/router/router_path.dart';
import 'package:advanced_task_manager/enums/task_priority.dart';
import 'package:advanced_task_manager/enums/task_state.dart';
import 'package:advanced_task_manager/ui/screens/home/home_notifier_provider.dart';
import 'package:advanced_task_manager/ui/widgets/appbar_home.dart';
import 'package:advanced_task_manager/ui/widgets/home/chip_info.dart';
import 'package:advanced_task_manager/ui/widgets/no_data.dart';
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
      body: DefaultTabController(
        length: 4,
        child: Column(
          children: [
            TabBar(
              onTap: (index) {
                TaskState? newFilter;
                switch (index) {
                  case 0:
                    newFilter = null;
                    break;
                  case 1:
                    newFilter = TaskState.pending;
                    break;
                  case 2:
                    newFilter = TaskState.inProgress;
                    break;
                  case 3:
                    newFilter = TaskState.completed;
                    break;
                }
                notifier.changeFilter(newFilter);
              },
              unselectedLabelColor: AppColors.greyMedium,
              tabs: const [
                Tab(text: AppStrings.all),
                Tab(text: AppStrings.pendings),
                Tab(text: AppStrings.inProgres),
                Tab(text: AppStrings.completed),
              ],
            ),
            Expanded(
              child: state.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : state.filteredTasks.isEmpty
                      ? noDataWidget(
                          text: AppStrings.noTasks,
                        )
                      : ListView.builder(
                          itemCount: state.filteredTasks.length,
                          itemBuilder: (context, index) {
                            final task = state.filteredTasks[index];
                            final colorBackground = task.state.getColor;
                            final colorTextPriority = task.priority.getColor;
                            final colorBackgroundPriority = task.priority.getBackgroundColor;
                            return Card(
                              elevation: 2,
                              color: AppColors.greyLight,
                              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              child: ListTile(
                                title: 
                                  Text(
                                    task.title, 
                                    style: AppTextStyles.blackInterBold16,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                tileColor: AppColors.greyLight,
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Row(
                                    children: [
                                      chipInfoWidget(
                                        label: task.state.getName, 
                                        colorBackground:  colorBackground.withOpacity(0.2),
                                        colorText: colorBackground,
                                      ),
                                      const SizedBox(width: 8),
                                      chipInfoWidget(
                                        label: task.priority.getName, 
                                        colorText: colorTextPriority,
                                        colorBackground: colorBackgroundPriority,
                                      ),
                                    ],
                                  ),
                                ),
                                contentPadding: const EdgeInsets.all(2),
                                leading: Checkbox(
                                  value: task.state == TaskState.completed,
                                  onChanged: (_) {
                                    notifier.toggleTaskCompleted(task);
                                  },
                                ),
                                onTap: () {
                                  Navigator.pushNamed(context, AppRoutes.taskAction, arguments: task);
                                },
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.taskAction).then(  (_) {
            notifier.loadTasks();
          });
        },
        backgroundColor: AppColors.primary,
        child: Icon(
          Icons.add, 
          color: AppColors.white,
          ),
      ),
    );
  }
}
