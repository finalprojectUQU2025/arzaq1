class MyPurchases {
  String? balance;
  int? purchases;
  List<Data>? data;

  MyPurchases();

  MyPurchases.fromJson(Map<String, dynamic> json) {
    balance = json['balance'];
    purchases = json['purchases'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add( Data.fromJson(v));
      });
    }
  }

}

class Data {
  int? id;
  String? name;
  String? image;
  String? quantity;
  Account? account;
  String? price;
  String? createdAt;

  Data();

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    quantity = json['quantity'];
    account =
    json['account'] != null ? new Account.fromJson(json['account']) : null;
    price = json['price'];
    createdAt = json['created_at'];
  }

}

class Account {
  int? id;
  String? name;

  Account();

  Account.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

}