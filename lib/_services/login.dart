import '../_models/user.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '../../_state/store.dart';
class Login {

  Future<void> sendEmailLogin({required String email, required dynamic store}) async {
    print(email);
    final url = Uri.parse('http://localhost:8080/user/login/stage1');
    final headers = {"Content-type": "application/json"};
    final json = '{"email": "$email"}';
    final response = await post(url, headers: headers, body: json);
    print('Status code: ${response.statusCode}');
    print('Body: ${response.body}');
    late dynamic responseJson=jsonDecode(response.body) ;
    if(responseJson["userRegister"]){
      //email déjà inscrit
      store.dispatch(loginActions.State2);
    }
    else{
      //nouvelle utilisateur
      print("nouvelle utilisateur");
    }



  }

}