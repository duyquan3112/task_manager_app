import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_manager_app/common/enum/bloc_status.dart';
import 'package:task_manager_app/common/utils/datetime_util.dart';
import 'package:task_manager_app/features/task_manager/repository/task_manager_repository.dart';
import 'package:task_manager_app/models/task_manager/filter_payload.dart';
import 'package:task_manager_app/models/task_manager/task_model.dart';
import 'package:task_manager_app/models/task_manager/task_request_model.dart';

import '../../../common/enum/filter_type.dart';

part 'task_manager_state.dart';

class TaskManagerCubit extends Cubit<TaskManagerState> {
  TaskManagerCubit() : super(const TaskManagerState());

  final _repository = TaskManagerRepository();

  FilterPayload _payload = FilterPayload();

  init() {
    updateFilterPayload(status: FilterType.all.id);
    emit(
      state.copyWith(
        filterSelected: _payload,
      ),
    );
  }

  updateFilterPayload({
    int? status,
    String? title,
  }) {
    _payload = _payload.copyWith(
      status: status,
      title: title,
    );
  }

  // Get tasks from database
  fetchAllData({bool showLoading = true}) async {
    if (showLoading) {
      emit(state.copyWith(
        fetchStatus: BlocStatus.loading,
      ));
    }
    await Future.delayed(Duration(milliseconds: 1000));
    final result = await _repository.getAll();

    emit(state.copyWith(
      fetchStatus: BlocStatus.success,
      taskList: result.result,
    ));
  }

  fetchDataWithFilter({bool showLoading = true}) async {
    if (showLoading) {
      emit(state.copyWith(
        fetchStatus: BlocStatus.loading,
      ));
    }
    await Future.delayed(Duration(milliseconds: 1000));
    final result = await _repository.getTaskByFilter(filter: _payload.toJson());

    emit(state.copyWith(
      fetchStatus: BlocStatus.success,
      taskList: result.result,
    ));
  }

  // Update filter
  onSelectFilter({int? status, String? searchText}) async {
    updateFilterPayload(status: status, title: searchText);

    emit(state.copyWith(
      filterSelected: _payload,
    ));

    await fetchDataWithFilter();
  }

  // Delete a task
  onDelete({required int id}) {
    _repository.delete(id: id);

    emit(state.copyWith(
      deleteStatus: BlocStatus.success,
    ));
  }

  // Update a task
  onUpdate({TaskModel? taskData}) async {
    emit(state.copyWith(
      updateStatus: BlocStatus.loading,
    ));
    await Future.delayed(Duration(milliseconds: 1000));
    taskData = taskData?.copyWith(
      updatedDate: DateTimeUtil.convertDate(
        DateTime.now().toString(),
        fromFormat: DateTimeFormat.yyyy_MM_dd_HH_mm_ssSS,
        toFormat: DateTimeFormat.dd_MM_yyyy_HH_mm,
      ),
    );
    final result = await _repository.update(
      id: taskData!.id!,
      taskData: TaskRequestModel.fromJson(taskData.toJson()),
    );

    if (result) {
      emit(state.copyWith(
        updateStatus: BlocStatus.success,
      ));
    } else {
      emit(state.copyWith(
        updateStatus: BlocStatus.failure,
      ));
    }
  }

  // Create a task
  onCreate({
    required String title,
    String? description,
    required String dueDate,
  }) async {
    emit(state.copyWith(
      createStatus: BlocStatus.loading,
    ));
    await Future.delayed(Duration(milliseconds: 1000));
    final result = await _repository.create(
      taskData: TaskRequestModel(
        title: title,
        description: description,
        dueDate: DateTimeUtil.convertDate(
          dueDate,
          fromFormat: DateTimeFormat.yyyy_MM_dd_HH_mm,
          toFormat: DateTimeFormat.dd_MM_yyyy_HH_mm,
        ),
        createdDate: DateTimeUtil.convertDate(
          DateTime.now().toString(),
          fromFormat: DateTimeFormat.yyyy_MM_dd_HH_mm_ssSS,
          toFormat: DateTimeFormat.dd_MM_yyyy_HH_mm,
        ),
        status: 0,
        updatedDate: DateTimeUtil.convertDate(
          DateTime.now().toString(),
          fromFormat: DateTimeFormat.yyyy_MM_dd_HH_mm_ssSS,
          toFormat: DateTimeFormat.dd_MM_yyyy_HH_mm,
        ),
      ),
    );

    if (result) {
      emit(state.copyWith(
        createStatus: BlocStatus.success,
      ));
    } else {
      emit(state.copyWith(
        createStatus: BlocStatus.failure,
      ));
    }
  }

  refreshData() async {
    await fetchDataWithFilter(showLoading: false);
  }
}
