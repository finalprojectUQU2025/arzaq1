class SupplyHomeData {
  String? balance;
  int? product;
  int? transactions;
  int? orders;
  List<Auctions>? auctions;

  SupplyHomeData();

  SupplyHomeData.fromJson(Map<String, dynamic> json) {
    balance = json['balance'];
    product = json['product'];
    transactions = json['transactions'];
    orders = json['orders'];
    if (json['data'] != null) {
      auctions = <Auctions>[];
      json['data'].forEach((v) {
        auctions!.add( Auctions.fromJson(v));
      });
    }
  }

}

class Auctions {
  int? id;
  String? name;
  String? image;
  String? quantity;
  int? productId;
  String? status;

  Auctions();

  Auctions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    quantity = json['quantity'];
    productId = json['product_id'];
    status = json['status'];
  }

}