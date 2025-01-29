import 'package:equatable/equatable.dart';

abstract class BaseState extends Equatable {
  const BaseState();
}

class LoadingState extends BaseState {
  const LoadingState();

  @override
  List<Object> get props => [];
}

class FailedState extends BaseState {
  final String message;

  const FailedState(this.message);

  @override
  List<Object> get props => [];
}

class VoidState extends BaseState {
  @override
  List<Object?> get props => [];
}
