import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/common/buttons.dart';
import 'package:task_manager_app/common/colors.dart';
import 'package:task_manager_app/common/enum/bloc_status.dart';
import 'package:task_manager_app/common/size.dart';
import 'package:task_manager_app/common/utils/datetime_util.dart';
import 'package:task_manager_app/common/utils/debounce_util.dart';
import 'package:task_manager_app/common/utils/text_util.dart';
import 'package:task_manager_app/features/task_manager/cubit/task_manager_cubit.dart';
import 'package:task_manager_app/models/task_manager/task_model.dart';

import '../../../../../common/styles.dart';

class TaskEditFormComponent extends StatefulWidget {
  const TaskEditFormComponent({
    super.key,
    this.taskData,
  });

  final TaskModel? taskData;

  @override
  State<TaskEditFormComponent> createState() => _TaskEditFormComponentState();
}

class _TaskEditFormComponentState extends State<TaskEditFormComponent> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _dateTimeController;
  final DebounceUtil _debounce = DebounceUtil(milliseconds: 350);
  bool _isValidate = true;

  @override
  void initState() {
    _titleController = TextEditingController(text: widget.taskData?.title);
    _descriptionController = TextEditingController(text: widget.taskData?.description);
    _dateTimeController = TextEditingController(text: widget.taskData?.dueDate);
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _dateTimeController.dispose();
    _debounce.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskManagerCubit, TaskManagerState>(
      builder: (context, state) {
        return Dialog(
          backgroundColor: UIColors.instance.backgroundColor,
          child: Container(
            constraints: BoxConstraints(
              maxHeight: AppSize.instance.height * 0.7,
              minHeight: AppSize.instance.height * 0.45,
            ),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "Edit task",
                      style: UITextStyle.semiBold.copyWith(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: UIColors.instance.whiteColor,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueGrey.withValues(alpha: 0.1),
                          blurRadius: 4,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        spacing: 24,
                        children: [
                          TextFormField(
                            controller: _titleController,
                            style: UITextStyle.medium,
                            decoration: InputDecoration(
                              labelText: 'Title *',
                            ),
                            onChanged: (value) {
                              changeValidateStatus();
                            },
                            validator: (String? value) {
                              if (_isValidate && TextUtils.isEmpty(value)) {
                                setState(() {
                                  _isValidate = false;
                                });
                              }
                              return TextUtils.isEmpty(value) ? 'Title is required' : null;
                            },
                          ),
                          TextFormField(
                            controller: _descriptionController,
                            style: UITextStyle.medium,
                            decoration: InputDecoration(
                              labelText: 'Description',
                            ),
                            maxLines: 3,
                            minLines: 1,
                            maxLength: 500,
                          ),
                          DateTimePicker(
                            controller: _dateTimeController,
                            dateMask: DateTimeFormat.dd_MM_yyyy_HH_mm.getString,
                            type: DateTimePickerType.dateTime,
                            dateLabelText: 'Due date *',
                            style: UITextStyle.medium,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100),
                            initialDate: DateTimeUtil.getDate(
                              widget.taskData?.dueDate,
                              format: DateTimeFormat.dd_MM_yyyy_HH_mm,
                            ),
                            initialTime: TimeOfDay.now(),
                            validator: (String? value) {
                              if (_isValidate && TextUtils.isEmpty(value)) {
                                setState(() {
                                  _isValidate = false;
                                });
                              }
                              return TextUtils.isEmpty(value) ? 'Due date is required' : null;
                            },
                            onChanged: (value) {
                              changeValidateStatus();
                            },
                            onSaved: (value) {
                              changeValidateStatus();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  PrimaryButton(
                    isLoading: state.updateStatus.isLoading,
                    enabled: _isValidate,
                    width: double.infinity,
                    textColor: UIColors.instance.lightBlueColor,
                    onPressed: () async {
                      await validateAndSave(context);
                    },
                    title: "Save",
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  validateAndSave(BuildContext context) async {
    final FormState? form = _formKey.currentState;
    if (form?.validate() == true) {
      debugPrint('Form is valid');
      final cubit = context.read<TaskManagerCubit>();
      final taskData = widget.taskData?.copyWith(
        title: _titleController.text,
        dueDate: _dateTimeController.text,
        description: _descriptionController.text,
      );
      await cubit.onUpdate(taskData: taskData);
      if (context.mounted) {
        Navigator.maybePop(context);
      }
    } else {
      setState(() {
        _isValidate = false;
      });
    }
  }

  void changeValidateStatus() {
    _debounce.run(() {
      if (!_isValidate) {
        setState(() {
          _isValidate = true;
        });
      }
    });
  }
}
