import 'appState.dart';
import 'store_connect.dart';
import 'store_user.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../main.dart';


AppState appStateReducer(AppState state, action){
  return AppState(
    loginState: ConnectUser(state.loginState, action),
    user:dataUser(state.user, action),
    globalState:state.toJson(globalState: false)
  );
}



