import 'package:flutter/material.dart';
import 'package:task_manager_app/common/enum/app_mode.dart';
import 'package:task_manager_app/services/local/local_data_helper.dart';

import 'common/colors.dart';
import 'common/size.dart';
import 'features/task_manager/pages/task_manager_home_page/task_manager_home_page.dart';

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  ThemeMode _themeMode = ThemeMode.light;

  @override
  void initState() {
    super.initState();
    _loadThemeMode();
  }

  @override
  Widget build(BuildContext context) {
    AppSize.instance.init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: UIColors.instance.primaryColor,
        ),
        appBarTheme: AppBarTheme(
          scrolledUnderElevation: 0.0,
          foregroundColor: UIColors.instance.defaultColor,
          color: UIColors.instance.whiteColor,
        ),
        scaffoldBackgroundColor: UIColors.instance.backgroundColor,
        useMaterial3: true,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: UIColors.instance.defaultColor),
          bodyMedium: TextStyle(color: UIColors.instance.defaultColor),
          bodySmall: TextStyle(color: UIColors.instance.defaultColor),
          titleLarge: TextStyle(color: UIColors.instance.defaultColor),
          titleMedium: TextStyle(color: UIColors.instance.defaultColor),
          titleSmall: TextStyle(color: UIColors.instance.defaultColor),
          headlineLarge: TextStyle(color: UIColors.instance.defaultColor),
          headlineMedium: TextStyle(color: UIColors.instance.defaultColor),
          headlineSmall: TextStyle(color: UIColors.instance.defaultColor),
          labelLarge: TextStyle(color: UIColors.instance.defaultColor),
          labelMedium: TextStyle(color: UIColors.instance.defaultColor),
          labelSmall: TextStyle(color: UIColors.instance.defaultColor),
          displayLarge: TextStyle(color: UIColors.instance.defaultColor),
          displayMedium: TextStyle(color: UIColors.instance.defaultColor),
          displaySmall: TextStyle(color: UIColors.instance.defaultColor),
        )..apply(),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(color: UIColors.instance.defaultColor),
          labelStyle: TextStyle(color: UIColors.instance.defaultColor),
        ),
        dividerTheme: DividerThemeData(
          thickness: 1,
          color: UIColors.instance.backgroundColor,
        ),
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: UIColors.instance.primaryColor,
          linearTrackColor: UIColors.instance.lightBlueColor,
          circularTrackColor: Colors.transparent,
        ),
      ),
      themeMode: _themeMode,
      home: TaskManagerPage(
        updateThemeMode: _updateThemeMode,
        isDarkMode: _themeMode == ThemeMode.dark,
      ),
    );
  }

  _loadThemeMode() async {
    setState(() {
      _themeMode = LocalDataHelper.instance.getMode() == AppMode.dark.name ? ThemeMode.dark : ThemeMode.light;
    });
  }

  _saveThemeMode(bool isDarkMode) async {
    await LocalDataHelper.instance.setMode(isDarkMode ? AppMode.dark.name : AppMode.normal.name);
  }

  void _updateThemeMode(bool isDarkMode) {
    setState(() {
      _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
      _saveThemeMode(isDarkMode);
    });
  }
}
