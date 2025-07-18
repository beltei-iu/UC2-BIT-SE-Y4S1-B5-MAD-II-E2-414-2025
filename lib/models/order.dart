

class Order {

  int? id;
  int? productId;
  double? price;
  int? quantity;
  int? discount;

  Order({
    this.id,
    this.productId,
    this.price,
    this.quantity,
    this.discount
  });


  Map<String, dynamic> toMap() =>
     {
      'id': id,
      'productId': productId,
      'price': price,
       'quantity':quantity
    };

  factory Order.fromMap(Map<String, dynamic> map) =>
      Order(
          id: map['id'],
          productId: map['productId'],
          price: map['price'],
          quantity: map['quantity']
      );

}