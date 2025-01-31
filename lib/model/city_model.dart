class CityModel {
  int? id;
  String? name;
  String? image;

  CityModel();

  CityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

}