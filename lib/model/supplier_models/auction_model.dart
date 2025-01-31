class AuctionModel {
  int? id;
  String? image;
  String? name;
  String? product;
  String? quantity;
  String? startingPrice;
  String? status;
  String? address;
  String? endTime;
  String? createdAt;

  AuctionModel();

  AuctionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    product = json['product'];
    quantity = json['quantity'];
    startingPrice = json['starting_price'];
    status = json['status'];
    address = json['address'];
    endTime = json['end_time'];
    createdAt = json['created_at'];
  }

}