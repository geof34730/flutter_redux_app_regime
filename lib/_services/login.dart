import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'dart:convert';
import '../_state/store_user.dart';
import '../_state/store_connect.dart';
import '../_models/user.dart';

class ServiceLogin {

  Future<void> sendEmailLogin({required String email, required dynamic store}) async {
    String urlEnv= "${dotenv.get("URL_API")}/user/login/stage1";
    final url = Uri.parse(urlEnv);
    final headers = {"Content-type": "application/json"};
    final json = '{"email": "$email"}';
    final response = await post(url, headers: headers, body: json);
    store.dispatch(SetEmailLoginAction(email));
    if(jsonDecode(response.body)["userRegister"]){
      store.dispatch(loginActions.State2);
    }
    else{
      store.dispatch(loginActions.Register1);
    }
  }

  Future<Map<String, String>> sendEmailPasswordLogin({required String password,required BuildContext context, required dynamic store}) async {
    String urlEnv= "${dotenv.get("URL_API")}/user/login/stage2";
    final url = Uri.parse(urlEnv);
    final headers = {"Content-type": "application/json"};
    final json = '{"email": "${store.state.user.email}","password":"$password"}';
    final response = await post(url, headers: headers, body: json);
    if(response.statusCode==200){
      store.dispatch(loginActions.Logged);
      store.dispatch(SetUserConnectedLoginAction(jsonDecode(response.body)['user']));
      return {"statut":"success"};
    }
    else{
      return {"statut":"error","code":jsonDecode(response.body)['code'],"messageError":jsonDecode(response.body)['error']};
    }
  }

  Future<dynamic> sendEmailForgetPassword({required String email, required dynamic store, required String mail}) async {
    String urlEnv= "${dotenv.get("URL_API")}/user/sendcode";
    final url = Uri.parse(urlEnv);
    final headers = {"Content-type": "application/json"};
    final json = '{"email": "$email","mail":"$mail"}';
    final response = await post(url, headers: headers, body: json);
    return jsonDecode(response.body);
 }

  Future<dynamic> sendCodeForgetPassword({required String email,required String codereset, required dynamic store}) async {
    String urlEnv= "${dotenv.get("URL_API")}/user/passwordcodereset";
    final url = Uri.parse(urlEnv);
    final headers = {"Content-type": "application/json"};
    final json = '{"email": "$email","code":"$codereset"}';
    final response = await post(url, headers: headers, body: json);
    return jsonDecode(response.body);
  }

  Future<dynamic> sendForgetNewPassword({required String email,required dynamic codereset, required String password, required dynamic store}) async {
    String urlEnv= "${dotenv.get("URL_API")}/user/passwordnew";
    final url = Uri.parse(urlEnv);
    final headers = {"Content-type": "application/json"};
    final json = '{'
        '"email": "$email",'
        '"code":"$codereset",'
        '"password":"$password"'
        '}';
    final response = await post(url, headers: headers, body: json);
    return jsonDecode(response.body);
  }

  Future<dynamic> sendCodeValidationInscription({required String email,required String codevalidation, required dynamic store}) async {
    String urlEnv= "${dotenv.get("URL_API")}/user/validateinscription";
    final url = Uri.parse(urlEnv);
    final headers = {"Content-type": "application/json"};
    final json = '{"email": "$email","code":"$codevalidation"}';
    final response = await post(url, headers: headers, body: json);
    return jsonDecode(response.body);
  }

  Future<dynamic> addUserTeam({required Userdata userDataRegister,required dynamic store, required bool edit}) async {
    String urlEnv= "${dotenv.get("URL_API")}/user/userteamadd";
    final url = Uri.parse(urlEnv);
    final headers = {
      "Content-type": "application/json;charset=utf-8",
      "Authorization":"${userDataRegister.token}"
    };
    final json = '{'
        '"edit": "${edit}",'
        '"uuid": "${userDataRegister.uuid}",'
        '"email": "${userDataRegister.email}",'
        '"lastname":"${userDataRegister.lastname}",'
        '"firstname":"${userDataRegister.firstname}",'
        '"pseudo":"${userDataRegister.pseudo}",'
        '"imageprofil":"${userDataRegister.imageprofil}",'
        '"datenaissance":"${userDataRegister.datenaissance}",'
        '"sexe":"${userDataRegister.sexe}",'
        '"taille":"${userDataRegister.taille}",'
        '"uuidfamillyadmin":"${userDataRegister.uuidfamillyadmin}"'
        '}';
    final response = await post(url, headers: headers, body: json);
    store.dispatch(SetUserConnectedLoginAction(jsonDecode(response.body)['user']));
    return jsonDecode(response.body);
  }

}