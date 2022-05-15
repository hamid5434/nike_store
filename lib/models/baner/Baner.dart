class BanerEntity {
  int? id;
  String? image;
  int? linkType;
  String? linkValue;

  BanerEntity({this.id, this.image, this.linkType, this.linkValue});

  BanerEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    linkType = json['link_type'];
    linkValue = json['link_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['link_type'] = this.linkType;
    data['link_value'] = this.linkValue;
    return data;
  }
}

class BanerEntitys {
  final List<BanerEntity> list;

  BanerEntitys({required this.list});

  factory BanerEntitys.fromJson(List<dynamic> json) {
    return BanerEntitys(
        list: json.map((e) => BanerEntity.fromJson(e)).toList());
  }
}
