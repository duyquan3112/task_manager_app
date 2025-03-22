import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:task_manager_app/common/buttons.dart';
import 'package:task_manager_app/common/colors.dart';
import 'package:task_manager_app/common/images.dart';
import 'package:task_manager_app/common/styles.dart';
import 'package:task_manager_app/common/utils/datetime_util.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
    required this.title,
    required this.status,
    required this.dueDate,
    this.onOpenDetail,
  });

  final String title;
  final int status;
  final String dueDate;
  final Function()? onOpenDetail;

  @override
  Widget build(BuildContext context) {
    final dueDateFormatted = DateTimeUtil.getDate(dueDate, format: DateTimeFormat.dd_MM_yyyy_HH_mm);
    final isNeedAlert = dueDateFormatted == null
        ? false
        : (DateUtils.dateOnly(dueDateFormatted).isAtSameMomentAs(DateTime.now()) == true ||
                DateUtils.dateOnly(dueDateFormatted).isBefore(DateTime.now()) == true) &&
            status != 1;
    return Container(
      padding: EdgeInsets.fromLTRB(24, 10, 16, 10),
      decoration: BoxDecoration(
        color: UIColors.instance.whiteColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: Offset(0, 1),
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        title,
                        style: UITextStyle.semiBold.copyWith(
                          fontSize: 16,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (isNeedAlert) ...[
                      const SizedBox(
                        width: 12,
                      ),
                      Lottie.asset(
                        "assets/jsons/alert_animation.json",
                        height: 18,
                        width: 18,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  "Due date: $dueDate",
                  style: UITextStyle.regular.copyWith(
                    fontStyle: FontStyle.italic,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Row(
            children: [
              AnimatedSwitcher(
                duration: Duration(milliseconds: 250),
                child: status == 1
                    ? AppImage.asset(
                        asset: "ic_success",
                        height: 28,
                        width: 28,
                        fit: BoxFit.cover,
                      )
                    : AppImage.asset(
                        asset: "ic_pending",
                        height: 28,
                        width: 28,
                        fit: BoxFit.cover,
                      ),
              ),
              const SizedBox(
                width: 12,
              ),
              SplashButton(
                highlightColor: Colors.transparent,
                onTap: onOpenDetail,
                child: AppImage.asset(
                  asset: "ic_more",
                  height: 28,
                  width: 28,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
