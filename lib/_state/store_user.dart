import 'dart:ui';

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

class SetRegisterState1 {
  final dynamic user;
  SetRegisterState1({required this.user});
}

class SetUserLogOutLoginAction {
  final dynamic store;
  SetUserLogOutLoginAction(this.store);
}
class SetChangeLocalizationLanguage {
  final String lang;
  SetChangeLocalizationLanguage(this.lang);
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
  if (action is SetUserLogOutLoginAction) {
    action.store.state.user.resetUser();
  }
  if (action is SetRegisterState1) {
    state.saveUserRegister(action.user);
  }
  if (action is SetChangeLocalizationLanguage) {
    state.saveUserlanguage(action.lang);
  }



  return state;
}
