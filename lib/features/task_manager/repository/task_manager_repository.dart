import 'package:task_manager_app/models/task_manager/task_model.dart';

import '../../../models/base/base_response.dart';
import '../../../models/task_manager/task_request_model.dart';
import '../../../services/task_manager/task_manager_service.dart';

class TaskManagerRepository {
  Future<BaseResponse<List<TaskModel>>> getAll() async {
    return await TaskManagerServiceImpl.instance.getAll();
  }

  Future<BaseResponse<List<TaskModel>>> getTaskByFilter({required Map<String, dynamic> filter}) async {
    return await TaskManagerServiceImpl.instance.getTaskByFilter(filter: filter);
  }

  Future<BaseResponse<TaskModel>> getTaskById({required int id}) async {
    return await TaskManagerServiceImpl.instance.getTaskById(id: id);
  }

  Future<bool> create({required TaskRequestModel taskData}) async {
    return await TaskManagerServiceImpl.instance.create(taskData: taskData);
  }

  Future<bool> update({required TaskRequestModel taskData, required int id}) async {
    return await TaskManagerServiceImpl.instance.update(taskData: taskData, id: id);
  }

  Future<void> delete({required int id}) async {
    await TaskManagerServiceImpl.instance.delete(id: id);
  }
}
