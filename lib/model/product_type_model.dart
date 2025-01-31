class ProductType {
  int? id;
  String? name;
  String? image;

  ProductType();

  ProductType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

}