import 'package:advanced_task_manager/config/config_imports.dart';
import 'package:advanced_task_manager/enums/task_priority.dart';
import 'package:advanced_task_manager/enums/task_state.dart';
import 'package:advanced_task_manager/models/task_model.dart';
import 'package:advanced_task_manager/ui/screens/task_action/task_action_notifier_provider.dart';
import 'package:advanced_task_manager/utils/date_time_utils.dart';
import 'package:advanced_task_manager/utils/snackbar_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskFormScreen extends ConsumerWidget {
  final TaskModel? task;

  const TaskFormScreen({super.key, this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskCopy = task != null ? TaskModel(
      id: task!.id,
      title: task!.title,
      description: task!.description,
      starDate: task!.starDate,
      estimatedEndDate: task!.estimatedEndDate,
      observation: task!.observation,
      state: task!.state,
      priority: task!.priority,
    ) : null;
    final state = ref.watch(taskActionNotifierProvider(task));
    final notifier = ref.read(taskActionNotifierProvider(task).notifier);

    return WillPopScope(
      onWillPop: () async {
        notifier.resetForm(task: task == null ? null : taskCopy);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
            title: Text(
              task == null ? AppStrings.newTask : state.isEditing ? AppStrings.editTask : AppStrings.detailsTask,
              style: AppTextStyles.whiteInterBold20,
              ),
        ),
        body: state.isSaving
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(20),
                child: ListView(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextFormField(
                        enabled: task != null && state.isEditing ||
                          task == null ? true : false,
                        initialValue: state.task.title,
                        decoration: const InputDecoration(labelText: AppStrings.title),
                        onChanged: notifier.updateTitle,
                        maxLines: 2,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextFormField(
                        enabled: task != null && state.isEditing ||
                          task == null ? true : false,
                        initialValue: state.task.description,
                        decoration: const InputDecoration(labelText: AppStrings.description),
                        onChanged: notifier.updateDescription,
                        maxLines: 3,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextFormField(
                        enabled: task != null && state.isEditing ||
                          task == null ? true : false,
                        initialValue: state.task.observation,
                        decoration: const InputDecoration(labelText: AppStrings.observation),
                        onChanged: notifier.updateObservation,
                        maxLines: 4,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          flex: 7,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              title: Text(
                                  AppStrings.starDate,
                                  style: AppTextStyles.blackInterSemiBold14,
                                  ),
                              subtitle: Text(state.task.starDate.toStringDateTimeIso()),
                              enabled: task == null ? true : false,
                              trailing: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                child: IconButton(
                                  enableFeedback: task == null ? true : false,
                                  icon: const Icon(Icons.calendar_today),
                                  color: AppColors.white,
                                  onPressed: task == null ? () async {
                                    final date = await showDatePicker(
                                      context: context,
                                      initialDate: state.task.starDate,
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2100),
                                    );
                                    if (date != null) notifier.updateStartDate(date);
                                  } : () {},
                                  ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: const SizedBox(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: const SizedBox(),
                        ),
                        Expanded(
                          flex: 7,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              title: Text(
                                  AppStrings.endEstimatedDate,
                                  textAlign: TextAlign.right,
                                  style: AppTextStyles.blackInterSemiBold14,
                                  ),
                              subtitle: Text(
                                state.task.estimatedEndDate.toStringDateTimeIso(),
                                textAlign: TextAlign.right,
                                ),
                              leading: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                child: IconButton(
                                  icon: const Icon(Icons.calendar_today),
                                  color: AppColors.white,
                                  onPressed: task != null && state.isEditing ||
                                task == null ? () async {
                                      final date = await showDatePicker(
                                        context: context,
                                        initialDate: state.task.estimatedEndDate,
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2100),
                                      );
                                      if (date != null) notifier.updateEstimatedEndDate(date);
                                    } : () {},
                                  ),
                              ),
                              enabled: task != null && state.isEditing ||
                                task == null ? true : false,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: state.task.state.getColor.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: DropdownButtonFormField<TaskState>(
                              value: state.task.state,
                              decoration: const 
                                InputDecoration(
                                  labelText: AppStrings.state
                                ),
                              items: task != null && state.isEditing ||
                                task == null ? TaskState.values
                                  .map((e) => DropdownMenuItem(value: e, child: Text(e.getName)))
                                  .toList() : null,
                              disabledHint: Text(
                                state.task.state.getName,
                                style: TextStyle(color: Colors.grey),
                              ),
                              onChanged: (v) {
                                if (v != null) notifier.updateState(v);
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: const SizedBox(),
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: state.task.priority.getBackgroundColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: DropdownButtonFormField<TaskPriority>(
                              value: state.task.priority,
                              decoration: const InputDecoration(labelText: 'Prioridad'),
                              items: task != null && state.isEditing ||
                                task == null ? TaskPriority.values
                                  .map((e) => DropdownMenuItem(value: e, child: Text(e.getName)))
                                  .toList() : null,
                              disabledHint: Text(
                                state.task.priority.getName,
                                style: TextStyle(color: Colors.grey),
                              ),
                              onChanged: (v) {
                                if (v != null) notifier.updatePriority(v);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    if (task != null && state.isEditing ||
                        task == null)
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            final response = await notifier.saveTask();
                            if (response.status) {
                              notifier.resetForm();
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBarUtils.successAlert(
                                  message: response.message,
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.error ?? AppStrings.failedActionTask)),
                              );
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(AppColors.primary),
                          ),
                          child: Text(
                            task != null ? AppStrings.update : AppStrings.add,
                            style: AppTextStyles.whiteInterBold16,
                          ),
                        ),
                      ),
                    if (state.error != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          state.error!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                  ],
                ),
              ),
        floatingActionButton: task != null && taskCopy?.state != TaskState.completed ? FloatingActionButton(
          onPressed: () async {
            await notifier.enableEditTask(task: taskCopy);
          },
          backgroundColor: state.isEditing ? AppColors.red : AppColors.orange,
          child: Icon(
            state.isEditing ? Icons.close : Icons.edit,
            color: AppColors.white,
            ),
        ) : null,
      ),
    );
  }
}