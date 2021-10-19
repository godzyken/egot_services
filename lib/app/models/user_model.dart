import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';

class RxUserModel {
  final id = '0'.obs;
  final companyName = 'companyName'.obs;
  final status = 'status'.obs;
  final activity = 'activity'.obs;
  final specialisation = 'specialisation'.obs;
  final length = 0.obs;
  final matriculation = 'matriculation'.obs;
  final email = 'email'.obs;
  final location = 'location'.obs;
  final assurance = 'assurance'.obs;
}

class UserModel {
  UserModel({id, companyName, status, activity, specialisation, length, matriculation, email, location, assurance});

  final rx = RxUserModel();

  get assurance => rx.assurance.value;
  set assurance(value) => rx.assurance.value = value;

  get location => rx.location.value;
  set location(value) => rx.location.value = value;

  get email => rx.email.value;
  set email(value) => rx.email.value = value;

  get matriculation => rx.matriculation.value;
  set matriculation(value) => rx.matriculation.value = value;

  get length => rx.length.value;
  set length(value) => rx.length.value = value;

  get specialisation => rx.specialisation.value;
  set specialisation(value) => rx.specialisation.value = value;

  get activity => rx.activity.value;
  set activity(value) => rx.activity.value = value;

  get status => rx.status.value;
  set status(value) => rx.status.value = value;

  get companyName => rx.companyName.value;
  set companyName(value) => rx.companyName.value = value;

  get id => rx.id.value;
  set id(value) => rx.id.value = value;

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['companyName'];
    status = json['status'];
    activity = json['activity'];
    specialisation = json['specialisation'];
    length = json['length'];
    matriculation = json['matriculation'];
    email = json['email'];
    location = json['location'];
    assurance = json['assurance'];
  }

  UserModel.fromDocumentSnapshot(DocumentSnapshot? documentSnapshot) {
    id = documentSnapshot!.id;
    companyName = documentSnapshot["companyName"];
    status = documentSnapshot["status"];
    activity = documentSnapshot["activity"];
    specialisation = documentSnapshot["specialisation"];
    length = documentSnapshot["length"];
    matriculation = documentSnapshot["matriculation"];
    email = documentSnapshot["email"];
    location = documentSnapshot["location"];
    assurance = documentSnapshot["assurance"];
  }

  Map<String, dynamic> toJson() => {
    'assurance' : assurance,
    'location' : location,
    'email' : email,
    'matriculation' : matriculation,
    'length' : length,
    'specialisation' : specialisation,
    'activity' : activity,
    'status' : status,
    'companyName' : companyName,
    'id':id,
  };

  static List<UserModel> listFromJson(list) => List<UserModel>.from(list.map((x) => UserModel.fromJson(x)));
}
