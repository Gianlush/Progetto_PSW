class User {
  int id;
  String name;
  String surname;
  String email;


  User({this.id, this.name, this.surname,this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      surname: json['surname'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'firstName': name,
    'lastName': surname,
    'email': email,
  };

  @override
  String toString() {
    return name + " " + surname;
  }


}