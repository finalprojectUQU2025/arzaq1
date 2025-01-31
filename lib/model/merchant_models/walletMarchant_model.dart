class WalletmarchantDetails {
  String? balance;
  String? cardExpiry;
  String? cardNumber;

  List<MyTransaction>? myTransaction;

  WalletmarchantDetails();

  WalletmarchantDetails.fromJson(Map<String, dynamic> json) {
    balance = json['balance'];
    cardExpiry = json['cardExpiry'];
    cardNumber = json['cardNumber'];


    if (json['myTransaction'] != null) {
      myTransaction = <MyTransaction>[];
      json['myTransaction'].forEach((v) {
        myTransaction!.add( MyTransaction.fromJson(v));
      });
    }
  }

}



class MyTransaction {
  int? id;
  String? image;
  String? name;
  String? created_at;
  String? amount;

  MyTransaction();

  MyTransaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    created_at = json['created_at'];
    amount = json['amount'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id;
    map['image'] = image;
    map['name'] = name;
    map['created_at'] = created_at;
    map['amount'] = amount;

    return map;
  }

}