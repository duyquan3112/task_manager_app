import 'package:flutter/material.dart';
import 'package:task_manager_app/models/task_manager/filter_model.dart';

import '../../../../../common/buttons.dart';
import '../../../../../common/colors.dart';
import '../../../../../common/styles.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget({
    super.key,
    this.onSelect,
    this.filterData,
    this.padding,
    required this.filterSelected,
    this.selectedTextColor,
    this.unSelectedTextColor,
    this.selectedBackgroundColor,
    this.unSelectedBackgroundColor,
  });

  final Function(int)? onSelect;
  final List<FilterModel>? filterData;
  final int filterSelected;
  final EdgeInsets? padding;
  final Color? selectedTextColor;
  final Color? unSelectedTextColor;
  final Color? selectedBackgroundColor;
  final Color? unSelectedBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: ListView.separated(
        padding: padding,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final item = filterData?[index];
          final isSelected = filterSelected == item?.id;

          return SplashButton(
            highlightColor: Colors.transparent,
            onTap: () {
              var selectingFilter = item?.id;
              if (onSelect != null) {
                onSelect!(selectingFilter ?? 2);
              }
            },
            child: Chip(
              shape: const StadiumBorder(
                side: BorderSide(style: BorderStyle.none),
              ),
              label: Text(
                item?.value ?? "",
                style: isSelected
                    ? UITextStyle.medium.copyWith(
                        color: selectedTextColor ?? UIColors.instance.whiteColor,
                      )
                    : UITextStyle.regular.copyWith(
                        color: unSelectedTextColor ?? UIColors.instance.grayColor,
                      ),
              ),
              padding: const EdgeInsets.only(left: 12, right: 12, bottom: 7, top: 5),
              backgroundColor: isSelected
                  ? selectedBackgroundColor ?? UIColors.instance.primaryColor
                  : unSelectedBackgroundColor ?? UIColors.instance.whiteColor,
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            width: 8,
          );
        },
        itemCount: filterData?.length ?? 0,
      ),
    );
  }
}
