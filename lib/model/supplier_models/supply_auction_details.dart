class SupplyAuctionDetails {
  int? id;
  String? image;
  String? name;
  String? quantity;
  String? startingPrice;
  int? totalOffer;
  String? status;
  HighestOffer? highestOffer;
  List<AllOffer>? allOffer;

  SupplyAuctionDetails();

  SupplyAuctionDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    quantity = json['quantity'];
    startingPrice = json['starting_price'];
    totalOffer = json['totalOffer'];
    status = json['status'];
    highestOffer = json['highestOffer'] != null && json['highestOffer'] != ''
        ?  HighestOffer.fromJson(json['highestOffer'])
        : null;
    if (json['allOffer'] != null) {
      allOffer = <AllOffer>[];
      json['allOffer'].forEach((v) {
        allOffer!.add( AllOffer.fromJson(v));
      });
    }
  }

}

class HighestOffer {
  int? id;
  String? image;
  String? name;
  String? highestOffer;

  HighestOffer();

  HighestOffer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    highestOffer = json['highestOffer'];
  }

}

class AllOffer {
  int? id;
  String? image;
  String? name;
  String? city;
  String? offerAmount;

  AllOffer();

  AllOffer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    city = json['city'];
    offerAmount = json['offerAmount'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id;
    map['image'] = image;
    map['name'] = name;
    map['city'] = city;
    map['offerAmount'] = offerAmount;

    return map;
  }

}