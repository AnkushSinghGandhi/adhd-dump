class CartItem {
  final String id;
  final String dumpId;
  final String productName;
  final String price;
  final String merchant;
  final String thumbnailUrl;
  final DateTime addedAt;

  CartItem({
    required this.id,
    required this.dumpId,
    required this.productName,
    required this.price,
    required this.merchant,
    required this.thumbnailUrl,
    required this.addedAt,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'] as String,
      dumpId: json['dumpId'] as String,
      productName: json['productName'] as String,
      price: json['price'] as String,
      merchant: json['merchant'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
      addedAt: DateTime.parse(json['addedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dumpId': dumpId,
      'productName': productName,
      'price': price,
      'merchant': merchant,
      'thumbnailUrl': thumbnailUrl,
      'addedAt': addedAt.toIso8601String(),
    };
  }
}
