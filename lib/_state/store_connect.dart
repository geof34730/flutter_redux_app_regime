enum loginActions { State1, State2, Register, Logged, Logout}

dynamic ConnectUser(dynamic state, dynamic action) {
  switch (action) {
    case loginActions.State1:
      state="email";
      break;

    case loginActions.Logout:
      state="email";
      break;

    case loginActions.State2:
      state="password";
      break;

    case loginActions.Register:
      state="register";
      break;

    case loginActions.Logged:
      state="logged";
      break;
  }
  return state;
}
