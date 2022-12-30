import '../_models/loginState.dart';
import '../_models/loginStateParam.dart';
import '../_models/user.dart';
enum loginActions {
  State1,
  State2,
  Register1,
  Register2,
  Register3,
  Register4,
  Logged,
  Logout,
  LoggedAddUser1,
  LoggedAddUser2,
  LoggedViewPoids,
  LoggedAddPoids,
  LoggedEditPoids,
  LoggedListePoids
}
class LoggedEditUser1 {
  final String uuidMofify;
  LoggedEditUser1({required this.uuidMofify});
}
class LoggedEditUser2 {
  final String? uuidMofify;
  LoggedEditUser2({required this.uuidMofify});
}
dynamic ConnectUser( LoginState state, dynamic action) {
  if (action is LoggedEditUser1 || action is LoggedEditUser2) {
    state=LoginState(widget: (action is LoggedEditUser1 ? "logged-edit-user-1" : "logged-edit-user-2"), param: LoginStateParam(uuid:action.uuidMofify));
  }
  else {
     switch (action) {
       case loginActions.State1:
       case loginActions.Logout:
         state = LoginState(widget: "email", param: null);
         break;

       case loginActions.State2:
         state = LoginState(widget: "password", param: null);
         break;

       case loginActions.Register1:
         state = LoginState(widget: "register1", param: null);
         break;

       case loginActions.Register2:
         state = LoginState(widget: "register2", param: null);
         break;

       case loginActions.Register3:
         state = LoginState(widget: "register3", param: null);
         break;

       case loginActions.Register4:
         state = LoginState(widget: "register4", param: null);
         break;

       case loginActions.Logged:
         state = LoginState(widget: "logged", param: null);
         break;

       case loginActions.LoggedAddUser1:
         state = LoginState(widget: "logged-add-user-1", param: null);
         break;

       case loginActions.LoggedAddUser2:
         state = LoginState(widget: "logged-add-user-2", param: null);
         break;

       case loginActions.LoggedViewPoids:
         state = LoginState(widget: "logged-view-poids", param: null);
         break;

       case loginActions.LoggedAddPoids:
         state = LoginState(widget: "logged-add-poids", param: null);
         break;

       case loginActions.LoggedEditPoids:
         state = LoginState(widget: "logged-edit-poids", param: null);
         break;

       case loginActions.LoggedListePoids:
         state = LoginState(widget: "logged-liste-poids", param: null);
         break;
     }
   }
  return state;
}
