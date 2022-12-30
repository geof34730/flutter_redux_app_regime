import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'dart:convert';
import '../_state/store_user.dart';
import '../_state/store_connect.dart';
import '../_models/user.dart';

class ServiceUser {
  late BuildContext context;
  late Locale localizations=Localizations.localeOf(context);
  ServiceUser({
    required this.context,
  });

  Future<dynamic> register({required Userdata userDataRegister,required String passwordRegister}) async {
    String urlEnv= "${dotenv.get("URL_API")}/user/register";
    print(userDataRegister.datenaissance);
    final url = Uri.parse(urlEnv);
    final headers = {"Content-type": "application/json;charset=utf-8"};
    final json = '{'
        '"email": "${userDataRegister.email}",'
        '"lastname":"${userDataRegister.lastname}",'
        '"firstname":"${userDataRegister.firstname}",'
        '"pseudo":"${userDataRegister.pseudo}",'
        '"imageprofil":"${userDataRegister.imageprofil}",'
        '"datenaissance":"${userDataRegister.datenaissance}",'
        '"sexe":"${userDataRegister.sexe}",'
        '"taille":"${userDataRegister.taille}",'
        '"password":"$passwordRegister",'
        '"localizations":"$localizations"'
        '}';
    final response = await post(url, headers: headers, body: json);
    return jsonDecode(response.body);
  }

  Future<dynamic> addUpdateUserTeam({required Userdata userDataRegister,required dynamic store, required bool edit}) async {
    String urlEnv= (edit ? "${dotenv.get("URL_API")}/user/userteamupdate" : "${dotenv.get("URL_API")}/user/userteamadd");
    final url = Uri.parse(urlEnv);
    final headers = {
      "Content-type": "application/json;charset=utf-8",
      "Authorization":"${userDataRegister.token}"
    };
    final json = '{'
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

  Future<dynamic> deleteUserTeam({required String userUuidDelete,required dynamic store}) async {
    String urlEnv= "${dotenv.get("URL_API")}/user/userteamdelete";
    final url = Uri.parse(urlEnv);
    final headers = {
      "Content-type": "application/json;charset=utf-8",
      "Authorization":"${store.state.user.token}"
    };
    final json = '{'
        '"uuid": "${userUuidDelete}",'
        '"uuidfamillyadmin": "${store.state.user.uuidfamillyadmin}"'
        '}';
    final response = await post(url, headers: headers, body: json);
    store.dispatch(SetUserConnectedLoginAction(jsonDecode(response.body)['user']));
    return jsonDecode(response.body);
  }

}