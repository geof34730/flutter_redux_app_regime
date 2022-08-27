import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'dart:convert';
import '../_state/store_user.dart';
import '../_state/store_connect.dart';

class Login {

  Future<void> sendEmailLogin({required String email, required dynamic store}) async {
    String urlEnv= "${dotenv.get("URL_API")}/user/login/stage1";
    final url = Uri.parse(urlEnv);
    final headers = {"Content-type": "application/json"};
    final json = '{"email": "$email"}';
    final response = await post(url, headers: headers, body: json);
    print('Status code: ${response.statusCode}');
    print('Body: ${response.body}');
    late dynamic responseJson=jsonDecode(response.body) ;
    store.dispatch(SetEmailLoginAction(email));
    if(responseJson["userRegister"]){
      //email déjà inscrit
      store.dispatch(loginActions.State2);
    }
    else{
      //nouvelle utilisateur
      print("nouvelle utilisateur");
      store.dispatch(loginActions.Register);
    }
  }

}