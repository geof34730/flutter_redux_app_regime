enum loginActions { State1, State2, Register}

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
