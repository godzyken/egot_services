import 'package:egot_services/app/models/use_x_models.dart';
import 'package:getxfire/getxfire.dart';

class ContactModel {
  String? id, name, email, number, role, status;

  ContactModel(
      {this.id, this.name, this.email, this.number, this.role, this.status});

  ContactModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    number = json['number'];
    role = json['role'];
    status = json['status'];
  }

  ContactModel.fromDocumentSnapshot(DocumentSnapshot? documentSnapshot) {
    id = documentSnapshot!.id;
    name = documentSnapshot["name"];
    email = documentSnapshot["email"];
    number = documentSnapshot["number"];
    role = documentSnapshot["role"];
    status = documentSnapshot["status"];

  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'number': number,
    'role': role,
    'status': status,
  };
}
