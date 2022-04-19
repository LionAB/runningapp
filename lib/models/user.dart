class User {
  String email;
  User({
    required this.email,
  });

  User.fromJson(Map<String, dynamic> json) : email = json['email'];
}
