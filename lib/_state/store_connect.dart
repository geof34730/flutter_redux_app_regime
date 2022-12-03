
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
  LoggedEditUser1,
  LoggedEditUser2,
  LoggedViewPoids,
  LoggedAddPoids,
  LoggedEditPoids,
  LoggedListePoids
}

dynamic ConnectUser(dynamic state, dynamic action) {
  switch (action) {
    case loginActions.State1: case loginActions.Logout:
      state={"widget":"email","param":"null"};
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

    case loginActions.LoggedAddUser1:
      state="logged-add-user-1";
      break;

    case loginActions.LoggedAddUser2:
      state="logged-add-user-2";
      break;

    case loginActions.LoggedEditUser1:
      state="logged-edit-user-1";
      break;

    case loginActions.LoggedEditUser2:
      state="logged-edit-user-2";
      break;

    case loginActions.LoggedViewPoids:
      state="logged-view-poids";
      break;

    case loginActions.LoggedAddPoids:
      state="logged-add-poids";
      break;

    case loginActions.LoggedEditPoids:
      state="logged-edit-poids";
      break;

    case loginActions.LoggedListePoids:
      state="logged-liste-poids";
      break;

  }
  return state;
}
