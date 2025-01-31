class AllNotifications {
  int? id;
  String? title;
  String? details;
  int? isRead;
  String? status;
  String? nameMoz;
  String? imageMoz;
  String? cityMoz;
  String? createdAt;

  AllNotifications();

  AllNotifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    details = json['details'];
    isRead = json['is_read'];
    status = json['status'];
    nameMoz = json['name_moz'];
    imageMoz = json['image_moz'];
    cityMoz = json['city_moz'];
    createdAt = json['created_at'];
  }

}