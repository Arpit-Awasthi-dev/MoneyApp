import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../base_usecase/failures.dart';
import '../utils.dart';
import 'base_state.dart';

abstract class BaseCubit extends Cubit<BaseState> {
  BaseCubit(super.state);

  void handleFailure(Failure failure) {
    emit(FailedState(failure.message));
  }

  void logError(String err) {
    log(err, level: LogLevel.error);
  }
}
