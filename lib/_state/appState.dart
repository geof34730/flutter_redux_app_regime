import '../_models/user.dart';
import '../_models/loginState.dart';

class AppState {
  final LoginState loginState;
  final Userdata user;
  final dynamic globalState;

  AppState({
    required this.loginState,
    required this.user,
    required this.globalState,
  });

  factory AppState.initial() =>  AppState(
      loginState : LoginState(widget: "email", param: null),
      user : Userdata.initial(),
      globalState:'',
  );

  dynamic toJson({bool globalState = true}) {
    return {
      "loginState": loginState.toJson(loginState),
      "user": user.toJson((globalState ?  true : false)),
      "globalState": (globalState ?  toJson(globalState: false) : ''),
    };
  }
}



