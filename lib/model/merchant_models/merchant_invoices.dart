class MerchantInvoices {
  int? id;
  String? serialNumber;
  String? name;
  String? quantity;
  String? sellPrice;
  String? image;
  String? sellerName;
  String? sellerAddress;

  MerchantInvoices();

  MerchantInvoices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serialNumber = json['serial_number'];
    name = json['name'];
    quantity = json['quantity'];
    sellPrice = json['sellPrice'];
    image = json['image'];
    sellerName = json['sellerName'];
    sellerAddress = json['sellerAddress'];
  }

}