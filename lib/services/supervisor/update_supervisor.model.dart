class UpdateSupervisor {
  int? id;
  String? name;
  String? firstLastName;
  String? secondLastName;
  String? email;
  String? phone;

  UpdateSupervisor(
      {this.id,
        this.name,
        this.firstLastName,
        this.secondLastName,
        this.email,
        this.phone});

  factory UpdateSupervisor.fromJson(Map<String, dynamic> json) {
    return UpdateSupervisor(
      id: json['id'],
      name: json['name'],
      firstLastName: json['firstLastName'],
      secondLastName: json['secondLastName'],
      email: json['email'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'firstLastName': firstLastName,
      'secondLastName': secondLastName,
      'email': email,
      'phone': phone,
    };
  }
}
