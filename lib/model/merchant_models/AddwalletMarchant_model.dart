class AddWalletmarchant {
  int? balance;
  String? cardExpiry;
  String? cardNumber;


  AddWalletmarchant();

  AddWalletmarchant.fromJson(Map<String, dynamic> json) {
    balance = json['balance'];
    cardExpiry = json['cardExpiry'];
    cardNumber = json['cardNumber'];



  }

}



