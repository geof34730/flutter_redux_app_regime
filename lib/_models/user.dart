class Userdata {
  late final dynamic id;
  final String uuid;
  final String pseudo;
  final String email;
  final String password;
  final String profil;
  final DateTime datenaissance;
  final String sexe;
  final double taille;
  final String imageprofil;
  final String uuidfamillyadmin;
  final bool inscriptionvalide;

  Userdata(
      this.uuid,
      this.pseudo,
      this.email,
      this.password,
      this.profil,
      this.datenaissance,
      this.sexe,
      this.taille,
      this.imageprofil,
      this.uuidfamillyadmin,
      this.inscriptionvalide
      );

  Userdata.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        uuid = map["uuid"],
        pseudo = map["pseudo"],
        email = map["email"],
        password = map["password"],
        profil = map["profil"],
        datenaissance = map["datenaissance"],
        sexe = map["sexe"],
        taille = map["taille"],
        imageprofil = map["imageprofil"],
        uuidfamillyadmin = map["uuidfamillyadmin"],
        inscriptionvalide = map["inscriptionvalide"];

  get map => null;

  Map<String, Object?> toMap() {
    return {
      'uuid': uuid,
      'pseudo': pseudo,
      'email': email,
      'password': password,
      'profil': profil,
      'datenaissance': datenaissance,
      'sexe': sexe,
      'taille' : taille,
      "imageprofil" : imageprofil,
      "uuidfamillyadmin" : uuidfamillyadmin,
      "inscriptionvalide" : inscriptionvalide
    };
  }
}