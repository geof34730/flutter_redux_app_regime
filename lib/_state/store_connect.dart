
enum loginActions { State1, State2, Register1, Register2, Register3, Register4, Logged, Logout}

dynamic ConnectUser(dynamic state, dynamic action) {
  switch (action) {
    case loginActions.State1: case loginActions.Logout:
      state="email";
      break;

    case loginActions.State2:
      state="password";
      break;

    case loginActions.Register1:
      state="register1";
      break;

    case loginActions.Register2:
      state="register2";
      break;

    case loginActions.Register3:
      state="register3";
      break;

    case loginActions.Register4:
      state="register4";
      break;

    case loginActions.Logged:
      state="logged";
      break;
  }
  return state;
}
