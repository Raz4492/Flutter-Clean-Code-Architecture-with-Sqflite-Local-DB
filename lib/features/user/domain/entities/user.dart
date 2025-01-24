class User {
  final String name;
  final String email;
  final String birthDate;
  final String userName;
  final String isActive;
  String? syncStatus;

  User({
    this.syncStatus,
    required this.name,
    required this.email,
    required this.birthDate,
    required this.userName,
    required this.isActive,
  });

  // // From JSON constructor
  // factory User.fromJson(Map<String, dynamic> json) {
  //   return User(
  //     name: json['name'] ?? '',
  //     email: json['email'] ?? '',
  //     birthDate: json['birth_date'] ?? '',
  //     userName: json['userName'] ?? '',
  //     isActive: json['is_Active'] ?? '',
  //     syncStatus: json['sync_status'],
  //   );
  // }

  // // To JSON method
  // Map<String, dynamic> toJson() {
  //   return {
  //     'name': name,
  //     'email': email,
  //     'birth_date': birthDate,
  //     'userName': userName,
  //     'is_Active': isActive,
  //     'sync_status': syncStatus,
  //   };
  // }
}
