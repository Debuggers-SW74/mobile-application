import 'package:fastporte/models/value_objects/name.value_object.dart';

class Client {
  final Name name;
  final String email;
  final String profileUrl;
  final String description =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent est justo, consequat sit amet porta nec, vehicula nec mi. Pellentesque vehicula semper nunc, vitae cursus ipsum feugiat quis. Proin id congue elit. Aliquam elementum purus in mi morbi.';

  Client({required this.name, required this.email, required this.profileUrl});

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      name: Name.fromJson(json['name']),
      email: json['email'],
      profileUrl: json['picture']['large'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name.toJson(),
        'email': email,
        'profileUrl': profileUrl,
      };

  @override
  String toString() {
    return 'User{name: $name, email: $email, profileUrl: $profileUrl}';
  }
}
