import 'package:flutter/material.dart';

final lifecycleEventHandler = LifecycleEventHandler._();

class LifecycleEventHandler extends WidgetsBindingObserver {
  AppLifecycleState? appState;

  LifecycleEventHandler._();

  init() {
    WidgetsBinding.instance.addObserver(lifecycleEventHandler);
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    appState = state;
    switch (state) {
      case AppLifecycleState.resumed:
        _onForegroundHandler();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        _onBackgroundHandler();
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }

  _onForegroundHandler() {}

  _onBackgroundHandler() {
    ///
  }

  static void handleState({
    required AppLifecycleState state,
    Function()? onForeground,
    Function()? onBackground,
  }) {
    switch (state) {
      case AppLifecycleState.resumed:
        onForeground?.call();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        onBackground?.call();
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }
}
