class ProductSort {
  static const int lastest = 0;
  static const int populer = 1;
  static const int priceHighToLow = 2;
  static const int priceLowToHigh = 3;
}

class ProductEntity {
  int? id;
  String? title;
  int? price;
  int? discount;
  String? image;
  int? status;
  int? previousPrice;

  ProductEntity(
      {this.id,
      this.title,
      this.price,
      this.discount,
      this.image,
      this.status,
      this.previousPrice});

  ProductEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    discount = json['discount'];
    image = json['image'];
    status = json['status'];
    previousPrice = json['previous_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['image'] = this.image;
    data['status'] = this.status;
    data['previous_price'] = this.previousPrice;
    return data;
  }
}

class ProductEntitys {
  final List<ProductEntity> list;

  ProductEntitys({required this.list});

  factory ProductEntitys.fromJson(List<dynamic> json) {
    return ProductEntitys(
        list: json.map((e) => ProductEntity.fromJson(e)).toList());
  }
}
