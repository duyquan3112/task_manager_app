import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/common/buttons.dart';
import 'package:task_manager_app/common/enum/bloc_status.dart';
import 'package:task_manager_app/common/size.dart';
import 'package:task_manager_app/common/utils/text_util.dart';
import 'package:task_manager_app/features/task_manager/cubit/task_manager_cubit.dart';
import 'package:task_manager_app/models/task_manager/task_model.dart';

import '../../../../common/colors.dart';
import '../../../../common/images.dart';
import '../../../../common/loading.dart';
import '../../../../common/styles.dart';
import 'components/task_edit_form_component.dart';

class TaskManagerDetailPage extends StatefulWidget {
  const TaskManagerDetailPage({
    super.key,
    this.taskData,
  });

  final TaskModel? taskData;

  @override
  State<TaskManagerDetailPage> createState() => _TaskManagerDetailPageState();
}

class _TaskManagerDetailPageState extends State<TaskManagerDetailPage> {
  @override
  Widget build(BuildContext context) {
    final isCompleted = widget.taskData?.status == 1;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        scrolledUnderElevation: 0.0,
        title: Text(
          "Task Detail Page",
          style: UITextStyle.bold.copyWith(
            fontSize: 18,
          ),
        ),
      ),
      body: BlocConsumer<TaskManagerCubit, TaskManagerState>(
        listener: (context, state) {
          if (state.deleteStatus.isSuccess) {
            Future.delayed(Duration(milliseconds: 250), () {
              if (context.mounted) {
                Navigator.maybePop(context);
              }
            });
          } else if (state.updateStatus.isSuccess) {
            Future.delayed(Duration(milliseconds: 250), () {
              if (context.mounted) {
                Navigator.maybePop(context);
              }
            });
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              ListView(
                padding: EdgeInsets.fromLTRB(16, 24, 16, AppSize.instance.safeBottom + 100),
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.taskData?.title ?? "",
                          style: UITextStyle.semiBold.copyWith(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      if (!isCompleted) ...[
                        const SizedBox(
                          width: 24,
                        ),
                        SplashButton(
                          onTap: () {
                            _onUpdate(context, taskData: widget.taskData);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: UIColors.instance.accentYellowColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "Edit",
                                  style: UITextStyle.medium.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                AppImage.asset(
                                  asset: "ic_edit",
                                  width: 16,
                                  height: 16,
                                  fit: BoxFit.contain,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    width: AppSize.instance.width,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: UIColors.instance.whiteColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueGrey.withValues(alpha: 0.1),
                          blurRadius: 4,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Create date: ${widget.taskData?.createdDate ?? "-/-"}",
                          style: UITextStyle.regular,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          "Updated date: ${widget.taskData?.updatedDate ?? "-/-"}",
                          style: UITextStyle.regular,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          "Due date: ${widget.taskData?.dueDate ?? "-/-"}",
                          style: UITextStyle.regular,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    "Description",
                    style: UITextStyle.medium,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    width: AppSize.instance.width,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: UIColors.instance.whiteColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueGrey.withValues(alpha: 0.1),
                          blurRadius: 4,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                    child: Text(
                      TextUtils.isNotEmpty(widget.taskData?.description)
                          ? widget.taskData!.description!
                          : "Don't have description",
                      style: UITextStyle.regular.copyWith(
                        fontStyle: TextUtils.isEmpty(widget.taskData?.description) ? FontStyle.italic : null,
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                left: 16,
                right: 16,
                bottom: AppSize.instance.safeBottom + 24,
                child: Row(
                  children: [
                    Expanded(
                      child: SplashButton(
                        onTap: () {
                          if (widget.taskData?.id != null) {
                            _onDelete(context, id: widget.taskData!.id!);
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: UIColors.instance.accentRedColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Delete",
                                  style: UITextStyle.regular.copyWith(
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              AppImage.asset(
                                asset: "ic_trash",
                                width: 24,
                                height: 24,
                                fit: BoxFit.contain,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (!isCompleted) ...[
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: SplashButton(
                          onTap: () {
                            _onUpdate(context, taskData: widget.taskData, isComplete: true);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: UIColors.instance.accentGreenColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Mark Complete",
                                    style: UITextStyle.regular.copyWith(
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                AppImage.asset(
                                  asset: "ic_done",
                                  width: 24,
                                  height: 24,
                                  fit: BoxFit.contain,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Visibility(
                visible: state.updateStatus.isLoading,
                child: LoadingWidget.dark(),
              ),
            ],
          );
        },
      ),
    );
  }

  _onDelete(BuildContext context, {required int id}) {
    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: UIColors.instance.whiteColor,
          title: Text(
            "Confirm Delete!",
            style: UITextStyle.semiBold.copyWith(
              fontSize: 16,
            ),
          ),
          content: Text(
            "Task will be remove. Delete?",
            style: UITextStyle.regular.copyWith(
              fontSize: 14,
            ),
          ),
          actions: [
            SplashButton(
              highlightColor: Colors.transparent,
              onTap: () {
                Navigator.maybePop(context);
              },
              child: Text(
                "Cancel",
                style: UITextStyle.regular,
              ),
            ),
            SplashButton(
              highlightColor: Colors.transparent,
              onTap: () {
                context.read<TaskManagerCubit>().onDelete(id: id);
                Navigator.maybePop(context);
              },
              child: Text(
                "Delete",
                style: UITextStyle.medium.copyWith(
                  color: UIColors.instance.accentRedColor,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  _onUpdate(
    BuildContext context, {
    TaskModel? taskData,
    bool isComplete = false,
  }) {
    if (isComplete) {
      context.read<TaskManagerCubit>().onUpdate(taskData: taskData?.copyWith(status: 1));
      return;
    }

    return showDialog(
      context: context,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<TaskManagerCubit>(),
          child: TaskEditFormComponent(
            taskData: taskData,
          ),
        );
      },
    );
  }
}
