import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:money_app/presentation/pages/send_add_money_page/send_add_money_page.dart';

import '../../presentation/pages/home_page/home_page.dart';
import '../../presentation/pages/login_page/login_page.dart';
import '../../presentation/pages/transaction_history_page.dart';

class Routers {
  static RouteSettings? _settings;

  static Route<dynamic> toGenerateRoute(RouteSettings settings) {
    _settings = settings;

    switch (settings.name) {
      case LoginPage.routeName:
        return _pageRoute(builder: (context) {
          return const LoginPage();
        });

      case HomePage.routeName:
        return _pageRoute(builder: (context) {
          return const HomePage();
        });

      case SendAddMoneyPage.routeName:
        return _pageRoute(builder: (context) {
          return const SendAddMoneyPage();
        });

      case TransactionHistoryPage.routeName:
        return _pageRoute(builder: (context) {
          return const TransactionHistoryPage();
        });

      default:
        throw Exception('Route Not Found');
    }
  }

  static _pageRoute({required WidgetBuilder builder, bool showModal = false}) {
    if (kIsWeb) {
      return MaterialPageRoute(
        builder: builder,
        settings: _settings,
      );
    } else if (Platform.isAndroid) {
      return MaterialPageRoute(
        builder: builder,
        settings: _settings,
      );
    } else if (Platform.isIOS) {
      return CupertinoPageRoute(
        builder: builder,
        settings: _settings,
        fullscreenDialog: showModal,
      );
    }
  }
}
