class CartItems {
  List<CartItemEntity>? cartItems;
  int? payablePrice;
  int? totalPrice;
  int? shippingCost;

  CartItems(
      {this.cartItems, this.payablePrice, this.totalPrice, this.shippingCost});

  CartItems.fromJson(Map<String, dynamic> json) {
    if (json['cart_items'] != null) {
      cartItems = <CartItemEntity>[];
      json['cart_items'].forEach((v) {
        cartItems!.add(new CartItemEntity.fromJson(v));
      });
    }
    payablePrice = json['payable_price'];
    totalPrice = json['total_price'];
    shippingCost = json['shipping_cost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cartItems != null) {
      data['cart_items'] = this.cartItems!.map((v) => v.toJson()).toList();
    }
    data['payable_price'] = this.payablePrice;
    data['total_price'] = this.totalPrice;
    data['shipping_cost'] = this.shippingCost;
    return data;
  }
}

class CartItemEntity {
  int? cartItemId;
  Product? product;
  int? count;

  CartItemEntity({this.cartItemId, this.product, this.count});

  CartItemEntity.fromJson(Map<String, dynamic> json) {
    cartItemId = json['cart_item_id'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_item_id'] = this.cartItemId;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    data['count'] = this.count;
    return data;
  }
}

class Product {
  int? id;
  String? title;
  int? price;
  int? discount;
  String? image;
  int? status;
  int? categoryId;
  int? views;

  Product(
      {this.id,
        this.title,
        this.price,
        this.discount,
        this.image,
        this.status,
        this.categoryId,
        this.views});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    discount = json['discount'];
    image = json['image'];
    status = json['status'];
    categoryId = json['category_id'];
    views = json['views'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['image'] = this.image;
    data['status'] = this.status;
    data['category_id'] = this.categoryId;
    data['views'] = this.views;
    return data;
  }
}
