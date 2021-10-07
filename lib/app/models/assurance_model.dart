class Assurance {
  int? id;
  String? avatarUrl;
  String? gravatarId;
  String? organizationsUrl;
  Type? type;
  String? name;
  String? createdAt;
  String? updatedAt;

  Assurance(
      {this.id,
      this.avatarUrl,
      this.gravatarId,
      this.organizationsUrl,
      this.type,
      this.name,
      this.createdAt,
      this.updatedAt});

  Assurance.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    avatarUrl = json['avatar_url'];
    gravatarId = json['gravatar_id'];
    organizationsUrl = json['organizations_url'];
    type = json['type'] != null ? Type?.fromJson(json['type']) : null;
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['avatar_url'] = avatarUrl;
    data['gravatar_id'] = gravatarId;
    data['organizations_url'] = organizationsUrl;
    if (type != null) {
      data['type'] = type!.toJson();
    }
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Type {
  String? commercialProperty;
  String? vehiclesCommercial;
  ResponsibilityCivil? responsibilityCivil;
  OtherProtection? otherProtection;
  ExtraProtection? extraProtection;

  Type(
      {this.commercialProperty,
      this.vehiclesCommercial,
      this.responsibilityCivil,
      this.otherProtection,
      this.extraProtection});

  Type.fromJson(Map<String, dynamic> json) {
    commercialProperty = json['commercial_property'];
    vehiclesCommercial = json['vehicles_commercial'];
    responsibilityCivil = json['responsibility_civil'] != null
        ? ResponsibilityCivil?.fromJson(json['responsibility_civil'])
        : null;
    otherProtection = json['other_protection,'] != null
        ? OtherProtection?.fromJson(json['other_protection,'])
        : null;
    extraProtection = json['extra_protection'] != null
        ? ExtraProtection?.fromJson(json['extra_protection'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['commercial_property'] = commercialProperty;
    data['vehicles_commercial'] = vehiclesCommercial;
    if (responsibilityCivil != null) {
      data['responsibility_civil'] = responsibilityCivil!.toJson();
    }
    if (otherProtection != null) {
      data['other_protection,'] = otherProtection!.toJson();
    }
    if (extraProtection != null) {
      data['extra_protection'] = extraProtection!.toJson();
    }
    return data;
  }
}

class ResponsibilityCivil {
  bool? responsibilityCivil;
  String? exploitation;
  String? delivery;
  String? specific;

  ResponsibilityCivil(
      {this.responsibilityCivil,
      this.exploitation,
      this.delivery,
      this.specific});

  ResponsibilityCivil.fromJson(Map<String, dynamic> json) {
    responsibilityCivil = json['responsibility_civil'];
    exploitation = json['exploitation'];
    delivery = json['delivery'];
    specific = json['specific'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['responsibility_civil'] = responsibilityCivil;
    data['exploitation'] = exploitation;
    data['delivery'] = delivery;
    data['specific'] = specific;
    return data;
  }
}

class OtherProtection {
  String? lostExploitation;
  String? contreCrime;

  OtherProtection({this.lostExploitation, this.contreCrime});

  OtherProtection.fromJson(Map<String, dynamic> json) {
    lostExploitation = json['lost_exploitation'];
    contreCrime = json['contre_crime'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['lost_exploitation'] = lostExploitation;
    data['contre_crime'] = contreCrime;
    return data;
  }
}

class ExtraProtection {
  String? cyberRisks;
  SeepageAndWaterDamage? seepageAndWaterDamage;

  ExtraProtection({this.cyberRisks, this.seepageAndWaterDamage});

  ExtraProtection.fromJson(Map<String, dynamic> json) {
    cyberRisks = json['cyber_risks'];
    seepageAndWaterDamage = json['seepage_and_water_damage'] != null
        ? SeepageAndWaterDamage?.fromJson(json['seepage_and_water_damage'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['cyber_risks'] = cyberRisks;
    if (seepageAndWaterDamage != null) {
      data['seepage_and_water_damage'] = seepageAndWaterDamage!.toJson();
    }
    return data;
  }
}

class SeepageAndWaterDamage {
  String? flooding;
  bool? sewerBackupAndOverflow;

  SeepageAndWaterDamage({this.flooding, this.sewerBackupAndOverflow});

  SeepageAndWaterDamage.fromJson(Map<String, dynamic> json) {
    flooding = json['flooding'];
    sewerBackupAndOverflow = json['sewer_backup_and_overflow'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['flooding'] = flooding;
    data['sewer_backup_and_overflow'] = sewerBackupAndOverflow;
    return data;
  }
}
