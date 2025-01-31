class MySales {
  int? allSale;
  String? profits;
  List<Sales>? sales;

  MySales();

  MySales.fromJson(Map<String, dynamic> json) {
    allSale = json['allSale'];
    profits = json['profits'];
    if (json['data'] != null) {
      sales = <Sales>[];
      json['data'].forEach((v) {
        sales!.add(Sales.fromJson(v));
      });
    }
  }

}

class Sales {
  int? id;
  String? name;
  String? image;
  String? quantity;
  String? buyer;
  String? price;
  String? createdAt;

  Sales();

  Sales.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    quantity = json['quantity'];
    buyer = json['buyer'];
    price = json['price'];
    createdAt = json['created_at'];
  }

}