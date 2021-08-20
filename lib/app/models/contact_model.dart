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

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'number': number,
    'role': role,
    'status': status,
  };
}
