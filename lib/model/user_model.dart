class UserModel {
  String? name;
  String? email;
  String? password;

  UserModel({
    this.name,
    this.email,
    this.password
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
   password =json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    void writeNotNull(String key, dynamic value) {
      if (value != null && value.toString().isNotEmpty) {
        data[key] = value;
      }
    }
    writeNotNull("name", name);
    writeNotNull("email", email);
    writeNotNull("email", password);
    return data;
  }

}
