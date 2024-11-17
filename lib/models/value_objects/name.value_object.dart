
class Name {
  final String title;
  final String firstName;
  final String lastName;

  Name({
    required this.title,
    required this.firstName,
    required this.lastName,
  });

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      title: json['title'],
      firstName: json['first'],
      lastName: json['last'],
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'first': firstName,
        'last': lastName,
      };

  String get fullName => '$firstName $lastName';

  @override
  String toString() {
    return 'Name{title: $title, firstName: $firstName, lastName: $lastName}';
  }

}