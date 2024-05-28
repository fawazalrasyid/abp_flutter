class Product {
  final int id;
  final String name;
  final int price;

  final String? description;
  final String? processor;
  final String? memory;
  final String? storage;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    this.description,
    this.processor,
    this.memory,
    this.storage,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'] ?? 0,
      description: json['description'],
      processor: json['processor'],
      memory: json['memory'],
      storage: json['storage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'description': description,
      'processor': processor,
      'memory': memory,
      'storage': storage,
    };
  }
}
