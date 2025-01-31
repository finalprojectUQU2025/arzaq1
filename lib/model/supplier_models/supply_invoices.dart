class SupplyInvoices {
  int? id;
  String? serialNumber;
  String? name;
  String? quantity;
  String? sellPrice;
  String? image;
  String? buyerName;
  String? buyerAddress;

  SupplyInvoices();

  SupplyInvoices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serialNumber = json['serial_number'];
    name = json['name'];
    quantity = json['quantity'];
    sellPrice = json['sellPrice'];
    image = json['image'];
    buyerName = json['buyerName'];
    buyerAddress = json['buyerAddress'];
  }

}