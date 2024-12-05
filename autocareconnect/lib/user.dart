class UserCar {
  // Define properties for the car
  final String make;
  final String model;
  final int year;
  final String color;
  final String userId;  // To associate the car with a specific user

  // Constructor
  UserCar({
    required this.make,
    required this.model,
    required this.year,
    required this.color,
    required this.userId,
  });

  // Method to display information about the car
  void displayInfo() {
    print('Car make: $make, model: $model, year: $year, color: $color, userId: $userId');
  }

  // Factory constructor to create a UserCar from JSON
  factory UserCar.fromJson(Map<String, dynamic> json) {
    return UserCar(
      make: json['make'],
      model: json['model'],
      year: json['year'],
      color: json['color'],
      userId: json['userId'],
    );
  }

  // Method to convert UserCar object to JSON
  Map<String, dynamic> toJson() {
    return {
      'make': make,
      'model': model,
      'year': year,
      'color': color,
      'userId': userId,
    };
  }
}
