import '../../domain/entities/hotel.dart';

class HotelModel extends Hotel {
  const HotelModel({
    required String name,
    required double price,
    required double rating,
    String? image,
    required String link,
    String? description, // Add description
  }) : super(
    name: name,
    price: price,
    rating: rating,
    image: image,
    link: link,
    description: description,
  );

  factory HotelModel.fromJson(Map<String, dynamic> json) {
    return HotelModel(
      name: json['name'] ?? 'Unknown Hotel',
      price: (json['rate_per_night']?['extracted_lowest'] ?? 0).toDouble(),
      rating: json['overall_rating'] ?? 0.0,
      image: (json['images']?.isNotEmpty ?? false) ? json['images'][0]['thumbnail'] : null,
      link: json['link'] ?? '',
      description: json['description'] ?? 'No description available', // Map description
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'rating': rating,
      'image': image,
      'link': link,
      'description': description, // Serialize description
    };
  }
}
