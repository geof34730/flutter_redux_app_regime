import 'appState.dart';
import 'store_connect.dart';
import 'store_user.dart';



AppState appStateReducer(AppState state, action) => AppState(
  loginState: ConnectUser(state.loginState, action),
  user:dataUser(state.user, action)
);