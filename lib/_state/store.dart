import 'appState.dart';
enum loginActions { State1, State2, Register}


class SetEmailLoginAction {
  final String email;
  SetEmailLoginAction(this.email);
}

dynamic ConnectUser(dynamic state, dynamic action) {
  switch (action) {
    case loginActions.State1:
      state="email";
      break;
    case loginActions.State2:
      state="password";
      break;

    case loginActions.Register:
      state="register";
      break;
  }
  return state;
}

dynamic dataUser(dynamic state, dynamic action) {
 if (action is SetEmailLoginAction) {
     state.updateEmail(action.email);
  }
  return state;
}

AppState appStateReducer(AppState state, action) => AppState(
  loginState: ConnectUser(state.loginState, action),
  user:dataUser(state.user, action)
);