class DevisModel {
  int? id;
  String? numDevis;
  StatusModel? statusModel;
  TypesLogementModel? typesLogementModel;
  SuperficieModel? superficieModel;
  TravauxModel? travauxModel;
  ContactClientModel? contactClientModel;
  MissionModel? missionModel;

  List<TravauxModel>? _listTravaux;
  List<MissionModel>? _listMissions;

  DevisModel(
      {this.id,
      this.numDevis,
      this.statusModel,
      this.typesLogementModel,
      this.superficieModel,
      this.travauxModel,
      this.contactClientModel,
      this.missionModel}) {
    _listMissions;
    _listTravaux;
  }

  DevisModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    numDevis = json['numDevis'];
    statusModel = json['statusModel'];
    typesLogementModel = json['typesLogementModel'];
    superficieModel = json['superficieModel'];
    travauxModel = json['travauxModel'];
    contactClientModel = json['contactClientModel'];
    missionModel = json['missionModel'];
    _listTravaux = json['listTravaux'];
    _listMissions = json['listMissions'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'numDevis': numDevis,
        'statusModel': statusModel,
        'typesLogementModel': typesLogementModel,
        'superficieModel': superficieModel,
        'travauxModel': travauxModel,
        'contactClientModel': contactClientModel,
        'missionModel': missionModel,
        '_listTravaux': _listTravaux,
        '_listMissions': _listMissions,
      };
}

class StatusModel {
  int? id;
  String? locataire, proprietaire;
  bool? isLocataire, isProprietaire;

  StatusModel({this.id, this.locataire, this.isLocataire, this.proprietaire});

  StatusModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    locataire = json['locataire'];
    isLocataire = json['isLocataire'];
    isProprietaire = json['isProprietaire'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'locataire': locataire,
        'proprietaire': proprietaire,
        'isLocataire': isLocataire,
        'isProprietaire': isProprietaire
      };
}

class TypesLogementModel {
  int? id;
  String? maison, appartement;
  bool? isMaison, isAppartement;

  TypesLogementModel(
      {this.id,
      this.maison,
      this.appartement,
      this.isMaison,
      this.isAppartement});

  TypesLogementModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    maison = json['maison'];
    appartement = json['appartement'];
    isMaison = json['isMaison'];
    isAppartement = json['isAppartement'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'maison': maison,
        'appartement': appartement,
        'isMaison': isMaison,
        'isAppartement': isAppartement,
      };
}

class SuperficieModel {
  int? surface;

  SuperficieModel({this.surface});

  SuperficieModel.fromJson(Map<String, dynamic> json) {
    surface = json['surface'];
  }

  Map<String, dynamic> toJson() => {'surface': surface};
}

class TravauxModel {
  int? id;
  String? denomination;
  MissionModel? mission;

  TravauxModel({this.id, this.denomination});

  TravauxModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    denomination = json['denomination'];
    mission = json['mission'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'denomination': denomination,
        'mission': mission,
      };
}

class ContactClientModel {
  int? id;
  String? firstName, lastName, numeroTel, email;

  ContactClientModel(
      {this.id, this.firstName, this.lastName, this.numeroTel, this.email});

  ContactClientModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    numeroTel = json['numeroTel'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'numeroTel': numeroTel,
        'email': email
      };
}

class MissionModel {
  int? id;
  String? denomination;

  MissionModel({this.id, this.denomination});

  MissionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    denomination = json['denomination'];
  }

  Map<String, dynamic> toJson() => {'id': id, 'denomination': denomination};
}
