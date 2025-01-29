import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_app/core/base_cubit/base_state.dart';
import 'package:money_app/presentation/cubits/user/user_cubit.dart';
import 'core/injection_container.dart' as di;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'core/bloc_providers.dart';
import 'core/navigation/navigation_service.dart';
import 'core/navigation/routers.dart';
import 'core/theme/app_theme.dart';
import 'presentation/pages/home_page/home_page.dart';
import 'presentation/pages/laucher_page.dart';
import 'presentation/pages/login_page/login_page.dart';

class MoneyApp extends StatefulWidget {
  final AdaptiveThemeMode theme;

  const MoneyApp({
    required this.theme,
    super.key,
  });

  @override
  State<MoneyApp> createState() => _MoneyAppState();
}

class _MoneyAppState extends State<MoneyApp> {
  late AdaptiveThemeMode currentTheme;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiBlocProvider(
      providers: BlocProviders.toGenerateProviders(),
      child: AdaptiveTheme(
        light: AppTheme.light,
        dark: AppTheme.dark,
        initial: widget.theme,
        builder: (light, dark) {
          return Builder(
            builder: (context) {
              return MaterialApp(
                home: BlocBuilder<UserCubit, BaseState>(
                  builder: (_, state) {
                    if (state is UserAuthStatus) {
                      if (state.isLoggedIn) {
                        return const HomePage();
                      } else {
                        return const LoginPage();
                      }
                    } else if (state is FailedState || state is LogoutUser) {
                      return const LoginPage();
                    }
                    return const LauncherPage();
                  },
                ),
                theme: light,
                darkTheme: dark,
                navigatorKey: di.sl<NavigationService>().navigatorKey,
                onGenerateRoute: (settings) =>
                    Routers.toGenerateRoute(settings),
                debugShowCheckedModeBanner: false,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
              );
            },
          );
        },
      ),
    );
  }
}
