import '../_models/user.dart';

class AppState {
  final String loginState;
  final Userdata user;

  AppState({
    required this.loginState,
    required this.user
  });

  factory AppState.initial() => AppState(
      loginState : "email",
      user : Userdata.initial()
  );

}



