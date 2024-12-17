import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final String category;
  final int stock;
  final List<String> imageUrls;
  final double rating;
  final int views;

  const ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.stock,
    required this.imageUrls,
    this.rating = 0.0,
    this.views = 0,
  });

  // Convert a ProductModel into a Map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'stock': stock,
      'imageUrls': imageUrls,
      'rating': rating,
      'views': views,
    };
  }

  factory ProductModel.fromMap(String id, Map<String, dynamic> map) {
    return ProductModel(
      id: id,
      name: map['name'],
      description: map['description'],
      price: map['price'],
      category: map['category'],
      stock: map['stock'],
      imageUrls: List<String>.from(map['imageUrls']),
      rating: map['rating'],
      views: map['views'],
    );
  }

  // Create a copy of this ProductModel with optional modifications.
  ProductModel copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? category,
    int? stock,
    List<String>? imageUrls,
    double? rating,
    int? views,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      category: category ?? this.category,
      stock: stock ?? this.stock,
      imageUrls: imageUrls ?? this.imageUrls,
      rating: rating ?? this.rating,
      views: views ?? this.views,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        category,
        stock,
        imageUrls,
        rating,
        views,
      ];

  @override
  String toString() {
    return 'ProductModel(id: $id, name: $name, description: $description, price: $price, category: $category, stock: $stock, imageUrls: $imageUrls, rating: $rating, views: $views)';
  }
}
