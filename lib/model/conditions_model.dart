class Conditions {
  int? id;
  String? title;
  String? subTitle;

  Conditions();

  Conditions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subTitle = json['sub_title'];
  }

}