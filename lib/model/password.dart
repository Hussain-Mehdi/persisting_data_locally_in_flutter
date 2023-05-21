class Password {
  Password(this.name, this.password);

  Password.formMap(Map<String, dynamic> map) {
    id:
    map['id'];
    name:
    map['name'];
    password:
    map['password'];
  }

  int? id;
  late String name;
  late String password;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'passowrd': password,
    };
  }
}
