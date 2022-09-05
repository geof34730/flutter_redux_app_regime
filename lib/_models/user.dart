import 'dart:convert';

class Userdata {
  late String? uuid;
  late String? pseudo;
  late  String? email;
  late String? profil;
  late String? datenaissance;
  late String? sexe;
  late int? taille;
  late String? imageprofil;
  late String? uuidfamillyadmin;
  late String? token;

  Userdata({
    required this.uuid,
    required this.pseudo,
    required this.email,
    required this.profil,
    required this.datenaissance,
    required this.sexe,
    required this.taille,
    required this.imageprofil,
    required this.uuidfamillyadmin,
    required this.token,
  });

  factory Userdata.initial() => Userdata(
      uuid:null,
      pseudo:null,
      email:null,
      profil:null,
      datenaissance:null,
      sexe:null,
      taille:null,
      imageprofil:null,
      uuidfamillyadmin:null,
      token:null

  );

  Userdata.fromMap(Map<String, dynamic> map)
      : uuid = map["uuid"],
        pseudo = map["pseudo"],
        email = map["email"],
        profil = map["profil"],
        datenaissance = map["datenaissance"],
        sexe = map["sexe"],
        taille = map["taille"],
        imageprofil = map["imageprofil"],
        uuidfamillyadmin = map["uuidfamillyadmin"],
        token = map["token"];

  dynamic toJson() {
    return {
      "uuid":uuid,
      "pseudo":pseudo,
      "email":email,
      "profil":profil,
      "datenaissance":datenaissance,
      "sexe":sexe,
      "taille":taille,
      "imageprofil":imageprofil,
      "uuidfamillyadmin":uuidfamillyadmin,
      "token":token
    };
  }

  updateEmail(String Email){
    email=Email;
  }

  saveUser(dynamic user){
    uuid = user["uuid"];
    pseudo = user["pseudo"];
    email = user["email"];
    profil = user["profil"];
    datenaissance = user["datenaissance"];
    sexe = user["sexe"];
    taille = user["taille"];
    imageprofil = user["imageprofil"].toString();
    uuidfamillyadmin = user["uuidfamillyadmin"];
    token = user["token"];
  }

}