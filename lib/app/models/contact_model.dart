class ContactModel {
  String? id, name, email, number, role, status;

  ContactModel(
      {this.id, this.name, this.email, this.number, this.role, this.status});

  ContactModel.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.name = json['name'];
    this.email = json['email'];
    this.number = json['number'];
    this.role = json['role'];
    this.status = json['status'];
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
