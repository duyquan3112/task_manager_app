import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/common/enum/bloc_status.dart';

import '../../../../common/buttons.dart';
import '../../../../common/colors.dart';
import '../../../../common/styles.dart';
import '../../../../common/utils/datetime_util.dart';
import '../../../../common/utils/debounce_util.dart';
import '../../../../common/utils/text_util.dart';
import '../../cubit/task_manager_cubit.dart';

class TaskManagerCreatePage extends StatefulWidget {
  const TaskManagerCreatePage({super.key});

  @override
  State<TaskManagerCreatePage> createState() => _TaskManagerCreatePageState();
}

class _TaskManagerCreatePageState extends State<TaskManagerCreatePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _dateTimeController;
  final DebounceUtil _debounce = DebounceUtil(milliseconds: 350);
  bool _isValidate = true;

  @override
  void initState() {
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _dateTimeController = TextEditingController();
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        scrolledUnderElevation: 0.0,
        title: Text(
          "Create new task",
          style: UITextStyle.bold.copyWith(
            fontSize: 18,
          ),
        ),
      ),
      body: BlocBuilder<TaskManagerCubit, TaskManagerState>(
        builder: (context, state) {
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 16),
            children: [
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
                    spacing: 12,
                    children: [
                      TextFormField(
                        onTapOutside: (ev) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
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
                        onTapOutside: (ev) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
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
                        initialDate: DateTime.now(),
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
                height: 24,
              ),
              PrimaryButton(
                isLoading: state.createStatus.isLoading,
                enabled: _isValidate,
                width: double.infinity,
                textColor: UIColors.instance.lightBlueColor,
                onPressed: () async {
                  await validateAndSave(context);
                },
                title: "Create",
              ),
              const SizedBox(
                height: 24,
              ),
            ],
          );
        },
      ),
    );
  }

  validateAndSave(BuildContext context) async {
    final FormState? form = _formKey.currentState;
    if (form?.validate() == true) {
      debugPrint('Form is valid');

      final cubit = context.read<TaskManagerCubit>();
      await cubit.onCreate(
        title: _titleController.text,
        dueDate: _dateTimeController.text,
        description: _descriptionController.text,
      );
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
