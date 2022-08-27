class SetEmailLoginAction {
  final String email;
  SetEmailLoginAction(this.email);
}

dynamic dataUser(dynamic state, dynamic action) {
  if (action is SetEmailLoginAction) {
    state.updateEmail(action.email);
  }
  return state;
}
