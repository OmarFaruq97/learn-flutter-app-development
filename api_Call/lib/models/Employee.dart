class Employee {
  final int? id;
  final String name;
  final String email;
  final String designation;
  final int age;
  final String address;
  final String dob;
  final double salary;
  final String? image;

  Employee({
    this.id,
    required this.name,
    required this.email,
    required this.designation,
    required this.age,
    required this.address,
    required this.dob,
    required this.salary,
    this.image,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      designation: json['designation'],
      age: json['age'],
      address: json['address'],
      dob: json['dob'],
      salary: (json['salary'] as num).toDouble(),
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // if (id != null)
      'id': id,
      'name': name,
      'email': email,
      'designation': designation,
      'age': age,
      'address': address,
      'dob': dob,
      'salary': salary,
      'image': image,
    };
  }
}
