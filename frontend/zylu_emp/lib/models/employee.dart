class Employee {
  final String id;
  final String name;
  final String role;
  final int years;
  final bool isActive;

// The backbone of every company - or at least that's what HR tells us

  Employee({
    required this.id,
    required this.name,
    required this.role,
    required this.years,
    required this.isActive,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['_id'] ?? '',
      name: json['name'],
      role: json['role'],
      years: json['years'],
      isActive: json['isActive'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "role": role,
      "years": years,
      "isActive": isActive,
    };
  }
}
