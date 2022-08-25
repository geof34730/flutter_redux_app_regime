import 'appState.dart';
enum loginActions { State1, State2}


//The reducer will take the action and create a state
// TODO: 5. update state values
dynamic ConnectUser(dynamic state, dynamic action) {
  print('ConnectUser ${state}');
  switch (action) {
    case loginActions.State1:
      state=1;
      break;

    case loginActions.State2:
      state=2;
      break;

  }
  print('ConnectUser ${state}');
  return state;
}





AppState appStateReducer(AppState state, action) => AppState(
    ConnectUser(state.loginState, action),
);