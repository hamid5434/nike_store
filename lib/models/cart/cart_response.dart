class CartResponse {
  int? productId;
  int? count;
  int? id;

  CartResponse({this.productId, this.count, this.id});

  CartResponse.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    count = json['count'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['count'] = this.count;
    data['id'] = this.id;
    return data;
  }
}
