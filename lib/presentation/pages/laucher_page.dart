import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_app/presentation/cubits/user/user_cubit.dart';

class LauncherPage extends StatelessWidget {
  const LauncherPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<UserCubit>().getUserAuthStatus();
    return const Scaffold();
  }
}
