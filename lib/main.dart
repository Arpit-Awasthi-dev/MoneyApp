import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:money_app/app.dart';
import 'core/app_config.dart';
import 'core/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppConfig();

  /// Service Locator Initialization
  await di.init();

  /// Get Theme
  final savedThemeMode =
      await AdaptiveTheme.getThemeMode() ?? AdaptiveThemeMode.light;

  runApp(MoneyApp(theme: savedThemeMode));
}
