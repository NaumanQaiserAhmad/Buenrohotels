import 'package:equatable/equatable.dart';

class Hotel extends Equatable {
  final String name;
  final String link;
  final double price;
  final double rating;
  final String? image; // Optional field for the image URL
  final String? description; // Optional field for the description

  const Hotel({
    required this.name,
    required this.link,
    required this.price,
    required this.rating,
    this.image,
    this.description,
  });

  @override
  List<Object?> get props => [name, link, price, rating, image, description];
}
