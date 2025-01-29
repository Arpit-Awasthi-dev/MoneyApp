part of 'user_cubit.dart';

class UserInitialState extends BaseState {
  @override
  List<Object?> get props => [];
}

class UserAuthStatus extends UserInitialState {
  final bool isLoggedIn;

  UserAuthStatus({required this.isLoggedIn});

  @override
  List<Object?> get props => [isLoggedIn];
}

class LogoutUser extends UserInitialState {
  final bool logout;

  LogoutUser({required this.logout});

  @override
  List<Object?> get props => [DateTime.now().microsecond];
}
