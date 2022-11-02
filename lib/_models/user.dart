

class Userdata {
  late String? uuid;
  late String? pseudo;
  late String? firstname;
  late String? lastname;
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
      token:null

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
        token = map["token"];

  dynamic toJson(globalState) {
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
      "imageprofil":(globalState ? imageprofil: imageprofil?.substring(0, 50)),
      "uuidfamillyadmin":uuidfamillyadmin,
      "token":token
    };
  }

  updateEmail(String Email){
    print("update email");
    print(email);
    email=Email;
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
  }

  saveUser(dynamic user){
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
  }


  saveUserRegister(dynamic user){
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
  }

}