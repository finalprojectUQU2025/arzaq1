import 'package:arzaq_app/model/supplier_models/supply_auction_details.dart';

class MerchantAuctionDetails {
  int? id;
  String? image;
  String? name;
  String? quantity;
  String? startingPrice;
  MazarieAccount? mazarieAccount;
  int? totalOffer;
  HighestOffer? highestOffer;
  List<AllOffer>? allOffer;

  MerchantAuctionDetails();

  MerchantAuctionDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    quantity = json['quantity'];
    startingPrice = json['starting_price'];
    mazarieAccount = json['mazarieAccount'] != null
        ? MazarieAccount.fromJson(json['mazarieAccount'])
        : null;
    totalOffer = json['totalOffer'];
    highestOffer = json['highestOffer'] != null && json['highestOffer'] != ''
        ? HighestOffer.fromJson(json['highestOffer'])
        : null;
    if (json['allOffer'] != null) {
      allOffer = <AllOffer>[];
      json['allOffer'].forEach((v) {
        allOffer!.add( AllOffer.fromJson(v));
      });
    }
  }

}

class MazarieAccount {
  int? id;
  String? image;
  String? name;

  MazarieAccount();

  MazarieAccount.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
  }

}


