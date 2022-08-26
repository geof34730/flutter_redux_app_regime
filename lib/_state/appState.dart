// Define your State
import '../_models/user.dart';

class AppState {
  dynamic loginState;
  Userdata user;

  AppState({
    required this.loginState,
    required this.user
  });

  factory AppState.initial() => AppState(
      loginState : "email",
      user : Userdata.initial()
  );

}



