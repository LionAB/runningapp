class User {
  String name;
  String email;
  User({
    required this.email,
    required this.name,
  });

  User.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        name = json['name'];
}
