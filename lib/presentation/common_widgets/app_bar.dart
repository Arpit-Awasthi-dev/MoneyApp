import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_app/core/extensions/context_extension.dart';
import 'package:money_app/core/navigation/navigation_service.dart';
import 'package:money_app/core/theme/color_schemes.dart';
import 'package:money_app/presentation/cubits/user/user_cubit.dart';

import '../../core/injection_container.dart';
import '../../core/theme/app_colors.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;

  const AppBarWidget({
    required this.title,
    this.leading,
    super.key,
  }) : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: false,
      title: Transform.translate(
        offset: const Offset(-8, 0),
        child: _title(context),
      ),
      leading: leading,
      titleSpacing: 0,
      actions: [
        IconContainer(
          iconData: context.isDarkMode ? Icons.light_mode : Icons.dark_mode,
          onClick: () {
            var value = context.isDarkMode;

            AdaptiveTheme.of(context).setThemeMode(
              !value ? AdaptiveThemeMode.dark : AdaptiveThemeMode.light,
            );
          },
        ),
        const SizedBox(width: 12),
        IconContainer(
          iconData: Icons.logout,
          onClick: () {
            var currContext =
                sl<NavigationService>().navigatorKey.currentContext;
            if (currContext != null) {
              currContext.read<UserCubit>().logout();
            }
          },
        ),
        const SizedBox(width: 12),
      ],
    );
  }

  Widget _title(BuildContext context) {
    return Text(
      title,
      style: context.textTheme.titleLarge,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  @override
  final Size preferredSize; // default is 56.0
}

class IconContainer extends StatelessWidget {
  final IconData iconData;
  final VoidCallback onClick;

  const IconContainer({
    required this.iconData,
    required this.onClick,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      child: GestureDetector(
        onTap: () {
          onClick();
        },
        child: Container(
          height: 36,
          width: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: context.colorScheme.appBarIconColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            iconData,
            color: AppColors.deepBlue,
            size: 20,
          ),
        ),
      ),
    );
  }
}
