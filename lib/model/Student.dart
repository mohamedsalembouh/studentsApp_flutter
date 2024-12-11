class Student {
  final int? id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String adresse;

  Student(
      {
        this.id,
      required this.firstName,
      required this.lastName,
      required this.adresse,
      required this.email,
      required this.phone});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        adresse: json['adress'],
        email: json['email'],
        phone: json['phone']);
  }

  Map toJson() {
    return {
     "firstName":firstName,
      "lastName":lastName,
      "adress":adresse,
      "email":email,
      "phone":phone
    };
  }
}
