import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_manager_app/common/colors.dart';
import 'package:task_manager_app/common/styles.dart';
import 'package:task_manager_app/common/toast/toast_provider.dart';

class DrawerComponent extends StatelessWidget {
  const DrawerComponent({
    super.key,
    this.updateThemeMode,
    this.isDarkMode = false,
  });

  final Function(bool)? updateThemeMode;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: UIColors.instance.whiteColor,
      child: Stack(
        children: [
          ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: UIColors.instance.backgroundColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'App Settings',
                      style: UITextStyle.semiBold.copyWith(
                        color: UIColors.instance.defaultColor,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Customize your app preferences',
                      style: UITextStyle.regular.copyWith(
                        color: UIColors.instance.defaultColor,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(
                  isDarkMode ? Icons.dark_mode : Icons.light_mode,
                  color: UIColors.instance.defaultColor,
                ),
                title: Text(
                  'App Theme',
                  style: UITextStyle.medium.copyWith(
                    color: UIColors.instance.defaultColor,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(
                  isDarkMode ? 'Dark Mode' : 'Light Mode',
                  style: UITextStyle.regular.copyWith(
                    color: UIColors.instance.defaultColor,
                    fontSize: 14,
                  ),
                ),
                trailing: Switch(
                  value: isDarkMode,
                  onChanged: (value) {
                    updateThemeMode?.call(value);
                  },
                ),
              ),
              Divider(),
              ListTile(
                leading: Icon(
                  Icons.info,
                  color: UIColors.instance.defaultColor,
                ),
                title: Text(
                  'About',
                  style: UITextStyle.regular.copyWith(
                    color: UIColors.instance.defaultColor,
                    fontSize: 14,
                  ),
                ),
                onTap: () {
                  ToastProvider.instance.show(
                    context: context,
                    message: "MADE BY QUAN NGUYEN",
                    gravity: ToastGravity.BOTTOM,
                  );
                },
              ),
            ],
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Text(
              "v1.0.0",
              style: UITextStyle.regular.copyWith(
                fontStyle: FontStyle.italic,
                fontSize: 13,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
