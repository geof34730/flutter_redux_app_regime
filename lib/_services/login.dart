import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:regime_redux_v2/_models/user.dart';
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

  Future<void> sendEmailPasswordLogin({required String password,required BuildContext context, required dynamic store}) async {
    String urlEnv= "${dotenv.get("URL_API")}/user/login/stage2";
    final url = Uri.parse(urlEnv);
    final headers = {"Content-type": "application/json"};
    final json = '{"email": "${store.state.user.email}","password":"$password"}';
    final response = await post(url, headers: headers, body: json);
    late dynamic responseJson=jsonDecode(response.body)['user'] ;
    if(response.statusCode==200){
      store.dispatch(loginActions.Logged);
      store.dispatch(SetUserConnectedLoginAction(responseJson));


    }
    else{
      print(jsonDecode(response.body)['error']);

      String messageError=jsonDecode(response.body)['error'];
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
            content: Text(messageError),
            backgroundColor: Colors.red,
        ),
      );
    }
  }

}