import 'appState.dart';
import 'store_connect.dart';
import 'store_user.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../main.dart';


AppState appStateReducer(AppState state, action){
  (dotenv.get("DEBUG")=="true" &&  printAppState(state: state));

  return AppState(
    loginState: ConnectUser(state.loginState, action),
    user:dataUser(state.user, action),
    globalState:state.toJson(globalState: false)
  );
}

bool printAppState({required AppState state}){
   /*   print('***************** globalState ****************');
        print(state.globalState);
      print('***************** END globalState ****************');
      */

  return true;
}