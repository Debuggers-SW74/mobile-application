class Vehicle {
  String id;
  String name;
  String brand;
  String model;
  String year;
  String color;
  String licensePlate;
  String image;
  String capacity;
  String typeOfCapacity;

  Vehicle({
    required this.id,
    required this.name,
    required this.brand,
    required this.model,
    required this.year,
    required this.color,
    required this.licensePlate,
    required this.image,
    required this.capacity,
    required this.typeOfCapacity,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'],
      name: json['name'],
      brand: json['brand'],
      model: json['model'],
      year: json['year'],
      color: json['color'],
      licensePlate: json['licensePlate'],
      image: json['image'],
      capacity: json['capacity'],
      typeOfCapacity: json['typeOfCapacity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'model': model,
      'year': year,
      'color': color,
      'licensePlate': licensePlate,
      'image': image,
      'capacity': capacity,
      'typeOfCapacity': typeOfCapacity,
    };
  }
}
