class MerchantHomeData {
  String? balance;
  int? transactions;
  List<OpenAuction>? openAuction;

  MerchantHomeData();

  MerchantHomeData.fromJson(Map<String, dynamic> json) {
    balance = json['balance'];
    transactions = json['transactions'];
    if (json['data'] != null) {
      openAuction = <OpenAuction>[];
      json['data'].forEach((v) {
        openAuction!.add(new OpenAuction.fromJson(v));
      });
    }
  }

}

class OpenAuction {
  int? id;
  String? name;
  String? image;
  String? quantity;

  OpenAuction();

  OpenAuction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    quantity = json['quantity'];
  }

}