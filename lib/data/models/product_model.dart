class ProductModel {
  String? id;

  String? category;

  String? brand;

  String? description;

  String? imageUrl;

  String? name;

  double? price;

  bool? offer;

  ProductModel({
    required this.id,
    required this.category,
    required this.brand,
    required this.description,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.offer,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      category: json['category'],
      brand: json['brand'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      name: json['name'],
      price: json['price'],
      offer: json['offer'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'brand': brand,
      'description': description,
      'imageUrl': imageUrl,
      'name': name,
      'price': price,
      'offer': offer
    };
  }
}
