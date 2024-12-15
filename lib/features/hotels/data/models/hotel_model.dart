import '../../domain/entities/hotel.dart';

class HotelModel extends Hotel {
  const HotelModel({
    required String name,
    required double price,
    required double rating,
    String? image,
    required String link,
    String? description,
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
      price: (json['rate_per_night']?['extracted_lowest'] ?? 0).toDouble(), // Extract nested price
      rating: json['overall_rating'] ?? 0.0, // Extract rating
      image: (json['images']?.isNotEmpty ?? false) ? json['images'][0]['thumbnail'] : null, // Extract first image
      link: json['link'] ?? '', // Extract link
      description: json['description'] ?? 'No description available', // Extract description
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'rate_per_night': {'extracted_lowest': price}, // Store price as nested structure
      'overall_rating': rating, // Store rating
      'images': image != null ? [{'thumbnail': image}] : [], // Store image as list of maps
      'link': link, // Store link
      'description': description, // Store description
    };
  }
}
