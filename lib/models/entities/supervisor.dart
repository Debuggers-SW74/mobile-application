class Supervisor {
  final int id;
  final String name;
  final String firstLastName;
  final String secondLastName;
  final String email;
  final String phone;
  final String username;
  final int userId;

  Supervisor({
    required this.id,
    required this.name,
    required this.firstLastName,
    required this.secondLastName,
    required this.email,
    required this.phone,
    required this.username,
    required this.userId,
  });

  factory Supervisor.fromJson(Map<String, dynamic> json) {
    return Supervisor(
      id: json['id'],
      name: json['name'],
      firstLastName: json['firstLastName'],
      secondLastName: json['secondLastName'],
      email: json['email'],
      phone: json['phone'],
      username: json['username'],
      userId: json['userId'],
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
      'username': username,
      'userId': userId,
    };
  }

  @override
  String toString() {
    return 'Supervisor{id: $id, name: $name, firstLastName: $firstLastName, secondLastName: $secondLastName, email: $email, phone: $phone, username: $username, userId: $userId}';
  }
}
