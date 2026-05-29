class Product {
  final int id;
  final String productName;
  final int stock;
  final double qty;
  final String productDescription;

  Product({
    required this.id,
    required this.productName,
    required this.stock,
    required this.qty,
    required this.productDescription,
  });

  // Safe JSON Parsing: Safely handles numeric casting and provides null defaults
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int? ?? 0,
      productName: json['productName'] as String? ?? '',
      stock: json['stock'] as int? ?? 0,
      qty: (json['qty'] as num? ?? 0.0).toDouble(),
      productDescription: json['productDescription'] as String? ?? '',
    );
  }
}