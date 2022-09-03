import '../_models/user.dart';

class SetEmailLoginAction {
  final String email;
  SetEmailLoginAction(this.email);
}

class SetEditPasswordAction {
  SetEditPasswordAction();
}

class SetPasswordAction {
  final String value;
  SetPasswordAction(this.value);
}

class SetUserConnectedLoginAction {
  final dynamic user;
  SetUserConnectedLoginAction(this.user);
}


dynamic dataUser(dynamic state, dynamic action) {
  if (action is SetEmailLoginAction) {
    state.updateEmail(action.email);
  }
  if (action is SetEditPasswordAction) {
    state.editPassword();
  }
  if (action is SetPasswordAction) {
    state.savePassword(action.value);
  }
  if (action is SetUserConnectedLoginAction) {
    state.saveUser(action.user);
  }

  return state;
}
