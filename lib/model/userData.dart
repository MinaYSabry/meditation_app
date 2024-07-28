class AppUserData {
  String? id;
  String? firstName;
  String? lastName;
  String? email;

  AppUserData(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.id});

  factory AppUserData.fromJson(Map<String, dynamic>? json) {
    return AppUserData(
      id: json!['id'],
      firstName: json["firstName"],
      lastName: json["lastName"],
      email: json["email"],
    );
  }
//
}
