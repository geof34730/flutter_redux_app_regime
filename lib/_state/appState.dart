import '../_models/user.dart';

class AppState {
  final String loginState;
  final Userdata user;
  final dynamic globalState;

  AppState({
    required this.loginState,
    required this.user,
    required this.globalState,
  });

  factory AppState.initial() =>  AppState(
      //loginState : {"widget":"email","param":"null"},

      loginState : "email",

      user : Userdata.initial(),
      globalState:'',
  );

  dynamic toJson({bool globalState = true}) {
    return {
      "loginState": loginState,
      "user": user.toJson((globalState ?  true : false)),
      "globalState": (globalState ?  toJson(globalState: false) : ''),
    };
  }
}



