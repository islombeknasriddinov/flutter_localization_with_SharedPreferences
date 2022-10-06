class Account{
  String? id;
  String? email;
  String? password;
  String? name;
  String? phone;

  Account(this.id, this.email, this.password, this.name, this.phone);
  Account.from(this.email, this.password, this.name, this.phone);

  Account.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        email = json['email'],
        password = json['password'],
        name = json['name'],
        phone = json['phone'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'password': password,
    'name' : name,
    'phone' : phone
  };
}