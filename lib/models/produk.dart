class ProductModel {
  final int id;
  final String name;
  final double price;
  final String description;
  final String createdAt;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.createdAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      price: double.parse(json['price'].toString()),
      description: json['description'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price.toInt(),
      'description': description,
    };
  }
}