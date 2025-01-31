class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? type;
  String? token;

  User();

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    type = json['type'];
    token = json['token'];
  }


}