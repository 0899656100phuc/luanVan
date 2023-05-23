class SearchData {
  int? id;
  String? name;
  String? subName;
  int? hotelsCount;
  String? image;

  SearchData({this.id, this.name, this.subName, this.hotelsCount, this.image});

  SearchData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    subName = json['sub_name'];
    image = json['image'];
    hotelsCount = json['hotels_count'];
  }
}
