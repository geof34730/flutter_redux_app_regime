class Userdata {
  late final dynamic? id;
  final String uuid;
  final String pseudo;
  late  String email;
  final String profil;
  final DateTime? datenaissance;
  final String sexe;
  final double? taille;
  final String imageprofil;
  final String uuidfamillyadmin;
  final bool inscriptionvalide;

  Userdata({
    this.id,
    required this.uuid,
    required this.pseudo,
    required this.email,
    required this.profil,
    required this.datenaissance,
    required this.sexe,
    required this.taille,
    required this.imageprofil,
    required this.uuidfamillyadmin,
    required this.inscriptionvalide,
  });

  factory Userdata.initial() => Userdata(
      id:null,
      uuid:"",
      pseudo:"",
      email:"",
      profil:"",
      datenaissance:null,
      sexe:"",
      taille:null,
      imageprofil:"",
      uuidfamillyadmin:"",
      inscriptionvalide:false
  );

  Userdata.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        uuid = map["uuid"],
        pseudo = map["pseudo"],
        email = map["email"],
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
      'profil': profil,
      'datenaissance': datenaissance,
      'sexe': sexe,
      'taille' : taille,
      "imageprofil" : imageprofil,
      "uuidfamillyadmin" : uuidfamillyadmin,
      "inscriptionvalide" : inscriptionvalide
    };
  }

  updateEmail(String Email){
    email=Email;
  }

}