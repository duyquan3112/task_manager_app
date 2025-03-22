import 'package:task_manager_app/database/database_helper.dart';
import 'package:task_manager_app/models/task_manager/task_model.dart';
import '../../../models/task_manager/task_request_model.dart';
import '../../models/base/base_response.dart';

abstract class TaskManagerService {
  Future<BaseResponse<List<TaskModel>>> getAll();

  Future<BaseResponse<TaskModel>> getTaskById({required int id});

  Future<BaseResponse<List<TaskModel>>> getTaskByFilter({required Map<String, dynamic> filter});

  Future<bool> create({required TaskRequestModel taskData});

  Future<bool> update({required TaskRequestModel taskData, required int id});

  Future<void> delete({required int id});
}

class TaskManagerServiceImpl extends TaskManagerService {
  static final instance = TaskManagerServiceImpl._();

  TaskManagerServiceImpl._();

  @override
  Future<bool> create({required TaskRequestModel taskData}) async {
    DatabaseHelper db = DatabaseHelper.instance;
    final result = await db.insert(taskData: taskData);
    return result;
  }

  @override
  Future<void> delete({required int id}) async {
    DatabaseHelper db = DatabaseHelper.instance;
    await db.delete(id: id);
  }

  @override
  Future<BaseResponse<List<TaskModel>>> getAll() async {
    DatabaseHelper db = DatabaseHelper.instance;
    final result = await db.getAll();
    return BaseResponse<List<TaskModel>>(
      status: true,
      result: result.map((e) => TaskModel.fromJson(e)).toList(),
    );
  }

  @override
  Future<BaseResponse<TaskModel>> getTaskById({required int id}) async {
    DatabaseHelper db = DatabaseHelper.instance;
    final result = await db.getById(id: id);
    return BaseResponse<TaskModel>(
      status: true,
      result: TaskModel.fromJson(result),
    );
  }

  @override
  Future<bool> update({required TaskRequestModel taskData, required int id}) async {
    DatabaseHelper db = DatabaseHelper.instance;
    return await db.update(id: id, taskData: taskData);
  }

  @override
  Future<BaseResponse<List<TaskModel>>> getTaskByFilter({required Map<String, dynamic> filter}) async {
    DatabaseHelper db = DatabaseHelper.instance;
    final result = await db.getByFilter(filter: filter);
    return BaseResponse<List<TaskModel>>(
      status: true,
      result: result.map((e) => TaskModel.fromJson(e)).toList(),
    );
  }
}
