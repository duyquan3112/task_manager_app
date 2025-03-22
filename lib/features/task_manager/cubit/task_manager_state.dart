part of 'task_manager_cubit.dart';

class TaskManagerState extends Equatable {
  final BlocStatus fetchStatus;
  final BlocStatus createStatus;
  final BlocStatus updateStatus;
  final BlocStatus deleteStatus;
  final List<TaskModel> taskList;
  final FilterPayload? filterSelected;
  final int? statusSelected;

  const TaskManagerState({
    this.fetchStatus = BlocStatus.initial,
    this.createStatus = BlocStatus.initial,
    this.updateStatus = BlocStatus.initial,
    this.deleteStatus = BlocStatus.initial,
    this.filterSelected,
    this.taskList = const [],
    this.statusSelected,
  });

  @override
  List<Object?> get props => [
        fetchStatus,
        createStatus,
        updateStatus,
        deleteStatus,
        filterSelected,
        taskList,
        statusSelected,
      ];

  TaskManagerState copyWith({
    BlocStatus? fetchStatus,
    BlocStatus? createStatus,
    BlocStatus? updateStatus,
    BlocStatus? deleteStatus,
    List<TaskModel>? taskList,
    FilterPayload? filterSelected,
    int? statusSelected,
  }) {
    return TaskManagerState(
      fetchStatus: fetchStatus ?? this.fetchStatus,
      createStatus: createStatus ?? BlocStatus.initial,
      updateStatus: updateStatus ?? BlocStatus.initial,
      deleteStatus: deleteStatus ?? BlocStatus.initial,
      taskList: taskList ?? this.taskList,
      filterSelected: filterSelected ?? this.filterSelected,
      statusSelected: statusSelected ?? this.statusSelected,
    );
  }
}

enum TableColName { title, status }
