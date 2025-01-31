class AuctionTimer {
  String? endTime;
  String? startTime;
  String? status;


  AuctionTimer();

  AuctionTimer.fromJson(Map<String, dynamic> json) {
    endTime = json['endTime'];
    startTime = json['startTime'];
    status = json['status'];

  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['endTime'] = endTime;
    map['startTime'] = startTime;
    map['status'] = status;

    return map;
  }

}