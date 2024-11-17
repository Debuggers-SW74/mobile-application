class Driver {
  final int id;
  final String name;
  final String firstLastName;
  final String secondLastName;
  final String email;
  final String phone;
  final String username;
  final int supervisorId;
  final int userId;

  Driver({
    required this.id,
    required this.name,
    required this.firstLastName,
    required this.secondLastName,
    required this.email,
    required this.phone,
    required this.username,
    required this.supervisorId,
    required this.userId,
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      id: json['id'],
      name: json['name'],
      firstLastName: json['firstLastName'],
      secondLastName: json['secondLastName'],
      email: json['email'],
      phone: json['phone'],
      username: json['username'],
      supervisorId: json['supervisorId'],
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
      'supervisorId': supervisorId,
      'userId': userId,
    };
  }

  @override
  String toString() {
    return 'Driver{id: $id, name: $name, firstLastName: $firstLastName, secondLastName: $secondLastName, email: $email, phone: $phone, username: $username, supervisorId: $supervisorId, userId: $userId}';
  }
}
