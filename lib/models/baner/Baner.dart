class BannerEntity {
  int? id;
  String? image;
  int? linkType;
  String? linkValue;

  BannerEntity({this.id, this.image, this.linkType, this.linkValue});

  BannerEntity.fromJson(Map<String, dynamic> json) {
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

class BannerEntitys {
  final List<BannerEntity> list;

  BannerEntitys({required this.list});

  factory BannerEntitys.fromJson(List<dynamic> json) {
    return BannerEntitys(
        list: json.map((e) => BannerEntity.fromJson(e)).toList());
  }
}
