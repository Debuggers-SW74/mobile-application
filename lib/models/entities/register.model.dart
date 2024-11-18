class RegisterUSer {
  String? name;
  String? firstLastName;
  String? secondLastName;
  String? email;
  String? username;
  String? password;
  String? phone;
  String? sensorCode;

  RegisterUSer(
      {this.name,
        this.firstLastName,
        this.secondLastName,
        this.email,
        this.username,
        this.password,
        this.phone,
        this.sensorCode});

  factory RegisterUSer.fromJson(Map<String, dynamic> json) {
    return RegisterUSer(
      name: json['name'],
      firstLastName: json['firstLastName'],
      secondLastName: json['secondLastName'],
      email: json['email'],
      username: json['username'],
      password: json['password'],
      phone: json['phone'],
      sensorCode: json['sensorCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'firstLastName': firstLastName,
      'secondLastName': secondLastName,
      'email': email,
      'username': username,
      'password': password,
      'phone': phone,
      'sensorCode': sensorCode,
    };
  }

  @override
  String toString() {
    return 'RegisterUSer{name: $name, firstLastName: $firstLastName, secondLastName: $secondLastName, email: $email, username: $username, password: $password, phone: $phone, sensorCode: $sensorCode}';
  }
}
