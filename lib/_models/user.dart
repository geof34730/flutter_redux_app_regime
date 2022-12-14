import 'package:flutter/material.dart';
String defaultLanguage="en";
class Userdata {
  late String? uuid;
  late String? pseudo;
  late String? firstname;
  late String? lastname;
  late String? email;
  late String? profil;
  late String? datenaissance;
  late String? sexe;
  late String? taille;
  late String? imageprofil;
  late String? uuidfamillyadmin;
  late String? token;
  late String localization;

  late List<Userdata>? usersFamily;
  late List<dynamic>? usersFamilyGlobalState;

  Userdata({
    required this.uuid,
    required this.pseudo,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.profil,
    required this.datenaissance,
    required this.sexe,
    required this.taille,
    required this.imageprofil,
    required this.uuidfamillyadmin,
    required this.token,
    required this.usersFamily,
    required this.usersFamilyGlobalState,
    required this.localization
  });

  factory Userdata.initial() => Userdata(
      uuid:null,
      pseudo:null,
      firstname:null,
      lastname:null,
      email:null,
      profil:null,
      datenaissance:null,
      sexe:null,
      taille:null,
      imageprofil:null,
      uuidfamillyadmin:null,
      token:null,
      usersFamily:null,
      usersFamilyGlobalState:null,
      localization:defaultLanguage

  );

  Userdata.fromMap(Map<String, dynamic> map)
      : uuid = map["uuid"],
        pseudo = map["pseudo"],
        firstname = map["firstname"],
        lastname = map["lastname"],
        email = map["email"],
        profil = map["profil"],
        datenaissance = map["datenaissance"],
        sexe = map["sexe"],
        taille = map["taille"],
        imageprofil = map["imageprofil"],
        uuidfamillyadmin = map["uuidfamillyadmin"],
        token = map["token"],
        usersFamily = map["usersFamily"],
        usersFamilyGlobalState =  map["usersFamilyGlobalState"],
        localization =  map["localization"];

  dynamic toJson() {
    return {
      "uuid":uuid,
      "pseudo":pseudo,
      "firstname":firstname,
      "lastname":lastname,
      "email":email,
      "profil":profil,
      "datenaissance":datenaissance,
      "sexe":sexe,
      "taille":taille,
      "imageprofil":imageprofil,
      "uuidfamillyadmin":uuidfamillyadmin,
      "token":token,
      "usersFamily":usersFamily.toString(),
      "usersFamilyGlobalState":usersFamilyGlobalState,
      "localization":localization
    };
  }

  updateEmail(String email){
    this.email=email;
  }

  resetUser(){
    uuid=null;
    pseudo=null;
    firstname=null;
    lastname=null;
    email=null;
    profil=null;
    datenaissance=null;
    sexe=null;
    taille=null;
    imageprofil=null;
    token=null;
    uuidfamillyadmin=null;
    usersFamily=null;
    usersFamilyGlobalState=null;
  }

  saveUser(dynamic user){
    List<Userdata> listUsersFamily=[];
    List<dynamic> listUsersFamilyGlobalSTate=[];
    for (var i = 0; i < user["usersFamily"].length; i++) {
      listUsersFamily.add(Userdata.fromMap(user["usersFamily"][i]));
    }

    for(var item in user["usersFamily"] ){
      dynamic tmpImageProfil=item['imageprofil'];
      item['imageprofil']=tmpImageProfil.substring(0, 50);
      listUsersFamilyGlobalSTate.add(item);
    }

    uuid = user["uuid"];
    pseudo = user["pseudo"];
    firstname = user["firstname"];
    lastname = user["lastname"];
    email = user["email"];
    profil = user["profil"];
    datenaissance = user["datenaissance"];
    sexe = user["sexe"];
    taille = user["taille"];
    imageprofil = user["imageprofil"].toString();
    uuidfamillyadmin = user["uuidfamillyadmin"];
    token = user["token"];
    usersFamily = listUsersFamily;
    usersFamilyGlobalState = listUsersFamilyGlobalSTate;
    localization = localization;
  }


  saveUserRegister(Userdata user){
    uuid=user.uuid;
    pseudo=user.pseudo;
    firstname=user.firstname;
    lastname=user.lastname;
    email=user.email;
    profil=user.profil;
    datenaissance=user.datenaissance;
    sexe=user.sexe;
    taille=user.taille;
    imageprofil=user.imageprofil;
    token=user.token;
    uuidfamillyadmin=user.uuidfamillyadmin;
    usersFamily=user.usersFamily;
    localization=user.localization;
  }

  saveUserlanguage(String lang){
    localization=lang;
  }


}