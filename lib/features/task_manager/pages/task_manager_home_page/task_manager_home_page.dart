import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/common/buttons.dart';
import 'package:task_manager_app/common/colors.dart';
import 'package:task_manager_app/common/enum/bloc_status.dart';
import 'package:task_manager_app/common/images.dart';
import 'package:task_manager_app/common/loading.dart';
import 'package:task_manager_app/common/styles.dart';
import 'package:task_manager_app/common/toast/toast_provider.dart';
import 'package:task_manager_app/common/utils/debounce_util.dart';
import 'package:task_manager_app/features/task_manager/cubit/task_manager_cubit.dart';
import 'package:task_manager_app/features/task_manager/pages/task_manager_create_page/task_manager_create_page.dart';
import 'package:task_manager_app/features/task_manager/pages/task_manager_detail_page/task_manager_detail_page.dart';
import 'package:task_manager_app/features/task_manager/pages/task_manager_home_page/components/drawer_component.dart';
import 'package:task_manager_app/features/task_manager/pages/task_manager_home_page/widgets/search_text_field_widget.dart';
import 'package:task_manager_app/models/task_manager/filter_model.dart';

import '../../../../common/enum/filter_type.dart';
import '../../../../models/task_manager/task_model.dart';
import 'items/task_item.dart';
import 'widgets/filter_widget.dart';

class TaskManagerPage extends StatefulWidget {
  const TaskManagerPage({
    super.key,
    this.updateThemeMode,
    this.isDarkMode = false,
  });

  final Function(bool)? updateThemeMode;
  final bool isDarkMode;

  @override
  State<TaskManagerPage> createState() => _TaskManagerPageState();
}

class _TaskManagerPageState extends State<TaskManagerPage> {
  final TextEditingController _searchController = TextEditingController();
  final DebounceUtil _debounce = DebounceUtil(milliseconds: 250);

  @override
  void dispose() {
    _searchController.dispose();
    _debounce.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filterData = [
      FilterModel(id: FilterType.all.id, value: "All"),
      FilterModel(id: FilterType.uncompleted.id, value: "Uncompleted"),
    ];
    return BlocProvider(
      create: (context) => TaskManagerCubit()
        ..init()
        ..fetchAllData(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: DrawerComponent(
          updateThemeMode: widget.updateThemeMode,
          isDarkMode: widget.isDarkMode,
        ),
        appBar: AppBar(
          centerTitle: true,
          scrolledUnderElevation: 0.0,
          title: Text(
            "Home Page",
            style: UITextStyle.bold.copyWith(
              fontSize: 18,
            ),
          ),
        ),
        body: BlocConsumer<TaskManagerCubit, TaskManagerState>(
          listener: (context, state) {
            if (state.deleteStatus.isSuccess || state.createStatus.isSuccess || state.updateStatus.isSuccess) {
              context.read<TaskManagerCubit>().refreshData();
              if (state.deleteStatus.isSuccess) {
                ToastProvider.instance.showSuccess(context: context, message: "Delete Success");
              } else if (state.createStatus.isSuccess) {
                ToastProvider.instance.showSuccess(context: context, message: "Create Success");
              } else if (state.updateStatus.isSuccess) {
                ToastProvider.instance.showSuccess(context: context, message: "Update Success");
              }
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Hi! ",
                                    style: UITextStyle.medium.copyWith(
                                      fontSize: 16,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "Quan Nguyen \n",
                                    style: UITextStyle.bold.copyWith(
                                      fontSize: 16,
                                      color: UIColors.instance.accentOrangeColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "Let's take a look!",
                                    style: UITextStyle.semiBold,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SplashButton(
                            onTap: () {
                              _openCreatePage(context);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: UIColors.instance.accentGreenColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    "Add",
                                    style: UITextStyle.medium.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  AppImage.asset(
                                    asset: "ic_add",
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
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      FilterWidget(
                        filterSelected: state.filterSelected?.status ?? FilterType.all.id,
                        filterData: filterData,
                        onSelect: (status) {
                          context.read<TaskManagerCubit>().onSelectFilter(status: status);
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      SearchTextFieldWidget(
                        controller: _searchController,
                        onSearch: (value) {
                          _debounce.run(() {
                            context.read<TaskManagerCubit>().onSelectFilter(searchText: value);
                          });
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      if (state.taskList.isEmpty && state.fetchStatus.isSuccess)
                        Center(
                          child: Text(
                            "Tasks not found :(",
                            style: UITextStyle.regular.copyWith(
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      if (state.taskList.isNotEmpty && state.fetchStatus.isSuccess)
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.only(top: 8, bottom: 30),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final task = state.taskList[index];
                              return Padding(
                                // Can use ListView.separated to create a gap between each item
                                // but the requirement is using ListView.builder
                                padding: EdgeInsets.only(bottom: index != 9 ? 12 : 0),
                                child: TaskItem(
                                  title: task.title ?? "",
                                  dueDate: task.dueDate ?? "",
                                  status: task.status ?? 0,
                                  onOpenDetail: () {
                                    _openDetailPage(context, taskData: task);
                                  },
                                ),
                              );
                            },
                            itemCount: state.taskList.length,
                          ),
                        ),
                    ],
                  ),
                ),
                Visibility(
                  visible: !state.fetchStatus.isSuccess,
                  child: LoadingWidget.dark(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  _openDetailPage(BuildContext context, {required TaskModel? taskData}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<TaskManagerCubit>(),
          child: TaskManagerDetailPage(
            taskData: taskData,
          ),
        ),
      ),
    );
  }

  _openCreatePage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<TaskManagerCubit>(),
          child: TaskManagerCreatePage(),
        ),
      ),
    );
  }
}
