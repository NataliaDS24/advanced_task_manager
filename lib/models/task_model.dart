import 'package:advanced_task_manager/config/config_imports.dart';
import 'package:advanced_task_manager/enums/task_priority.dart';
import 'package:advanced_task_manager/enums/task_state.dart';
import 'package:advanced_task_manager/utils/date_time_utils.dart';

class TaskModel {
  int? id;
  String title;
  String description;
  final DateTime starDate;
  DateTime estimatedEndDate;
  String observation;
  TaskState state;
  TaskPriority priority;

  TaskModel({
    this.id,
    required this.title,
    this.description = AppStrings.voidText,
    required this.starDate,
    required this.estimatedEndDate,
    this.observation = AppStrings.voidText,
    required this.state,
    required this.priority,
  });


  // From Map data online
  factory TaskModel.fromMap({required Map map}) {
    return TaskModel(
      title: map['title'] ?? AppStrings.voidText,
      description: map['description'] ?? AppStrings.voidText,
      starDate: map['starDate'] ?? DateTime.now(),
      estimatedEndDate: map['estimatedEndDate'] ?? DateTime.now(),
      observation: map['observation'] ?? AppStrings.voidText,
      state: map['state'] != null ? int.parse(map['state']).getValueState : TaskState.pending,
      priority: map['priority'] != null ? int.parse(map['priority']).getValuePriority : TaskPriority.low,
    );
  }

  // Offline data management
  factory TaskModel.fromMapOffline({
    required Map map,
  }) {
    final int state = map['state'];
    final int priority = map['priority'];
    return TaskModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      starDate:'${map['starDate']}'.toStringDateTimeFromIso(),
      estimatedEndDate: '${map['estimatedEndDate']}'.toStringDateTimeFromIso(),
      observation: map['observation'],
      state: state.getValueState,
      priority: priority.getValuePriority,
    );
  }

  Map<String, dynamic> toMapOffline() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'starDate': starDate.toStringDateTimeIso(),
      'estimatedEndDate': estimatedEndDate.toStringDateTimeIso(),
      'observation': observation,
      'state': state.getIntValue,
      'priority': priority.getIntValue,
    };
  }

  Map<String, dynamic> toMapUpdate() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'estimatedEndDate': estimatedEndDate.toStringDateTimeIso(),
      'observation': observation,
      'state': state.getIntValue,
      'priority': priority.getIntValue,
    };
  }
}
