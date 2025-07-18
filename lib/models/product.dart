
class Product {
  int? id;
  String? name;
  String? description;
  double? price;
  int? discount;
  int? rate;
  String? image;
  int? categoryId;

  Product({
    this.id,
    this.name,
    this.description,
    this.price,
    this.discount,
    this.rate,
    this.image,
    this.categoryId
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "price": price,
      "discount": discount,
      "rate": rate,
      "image": image,
      "categoryId": categoryId,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map["id"],
      name: map["name"],
      description: map["description"],
      price: map["price"],
      discount: map["discount"],
      rate: map["rate"],
      image: map["image"],
      categoryId: map["categoryId"],
    );
  }
}
