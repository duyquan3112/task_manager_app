import 'package:flutter/material.dart';
import 'package:task_manager_app/app_view.dart';

import 'config/general_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GeneralConfig.init();
  runApp(const AppView());
}
