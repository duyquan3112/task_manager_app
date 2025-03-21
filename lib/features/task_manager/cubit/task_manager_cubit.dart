import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'task_manager_state.dart';

class TaskManagerCubit extends Cubit<TaskManagerState> {
  TaskManagerCubit() : super(TaskManagerInitial());
}
