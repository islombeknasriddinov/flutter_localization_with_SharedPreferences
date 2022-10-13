class Users{
  String? id;
  String? email;
  String? password;

  Users(this.id, this.email, this.password);
  Users.from(this.email, this.password);

  Users.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        email = json['email'],
        password = json['password'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'password': password
  };
}