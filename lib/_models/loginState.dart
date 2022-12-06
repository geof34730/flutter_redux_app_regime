import 'loginStateParam.dart';

class LoginState {
  late String widget;
  late LoginStateParam? param;

  LoginState({
    required this.widget,
    required this.param,
  });

    factory LoginState.initial() => LoginState(
      widget:"email",
      param: null,
  );
  dynamic toJson(globalstate) {
    return {
      "widget":widget,
      "param":param
    };
  }
}