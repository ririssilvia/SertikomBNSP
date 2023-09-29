class Account {
  String? id, password;

  Account({required this.id, required this.password});
  Map<String, dynamic> toMap() {
    return {"id": id, "password": password};
  }

  Account.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    password = map['password'];
  }
}
