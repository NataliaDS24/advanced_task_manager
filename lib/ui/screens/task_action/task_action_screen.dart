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
            title: Text(task == null ? 'Nueva Tarea' : 'Editar Tarea'),
        ),
        body: state.isSaving
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    TextFormField(
                      enabled: task != null && state.isEditing ||
                        task == null ? true : false,
                      initialValue: state.task.title,
                      decoration: const InputDecoration(labelText: 'Título'),
                      onChanged: notifier.updateTitle,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      enabled: task != null && state.isEditing ||
                        task == null ? true : false,
                      initialValue: state.task.description,
                      decoration: const InputDecoration(labelText: 'Descripción'),
                      onChanged: notifier.updateDescription,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      enabled: task != null && state.isEditing ||
                        task == null ? true : false,
                      initialValue: state.task.observation,
                      decoration: const InputDecoration(labelText: 'Observación'),
                      onChanged: notifier.updateObservation,
                    ),
                    const SizedBox(height: 10),
                    ListTile(
                      title: Text('Fecha de inicio: ${state.task.starDate.toStringDateTimeIso()}'),
                      trailing: const Icon(Icons.calendar_today),
                      enabled: task == null ? true : false,
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: state.task.starDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (date != null) notifier.updateStartDate(date);
                      },
                    ),
                    ListTile(
                      title: Text(
                          'Fecha estimada de finalización: ${state.task.estimatedEndDate.toStringDateTimeIso()}'),
                      trailing: const Icon(Icons.calendar_today),
                      enabled: task != null && state.isEditing ||
                        task == null ? true : false,
                      onTap: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: state.task.estimatedEndDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (date != null) notifier.updateEstimatedEndDate(date);
                      },
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<TaskState>(
                      value: state.task.state,
                      decoration: const InputDecoration(labelText: 'Estado'),
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
                    const SizedBox(height: 10),
                    DropdownButtonFormField<TaskPriority>(
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
                    const SizedBox(height: 20),
                    if (task != null && state.isEditing ||
                        task == null)
                      ElevatedButton(
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
                            SnackBar(content: Text(state.error ?? 'Error al guardar tarea')),
                          );
                        }
                      },
                        child: const Text('Guardar'),
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
        floatingActionButton: task != null ? FloatingActionButton(
          onPressed: () async {
            await notifier.enableEditTask(task: taskCopy);
          },
          child: Icon(state.isEditing ? Icons.close : Icons.edit),
        ) : null,
      ),
    );
  }
}