import 'package:flutter/material.dart';
import '../../data/repositories/favorites_repository.dart';
import '../../domain/entities/hotel.dart';

class HotelCard extends StatefulWidget {
  final Hotel hotel;
  final bool isFavorite;

  const HotelCard({
    Key? key,
    required this.hotel,
    required this.isFavorite,
  }) : super(key: key);

  @override
  State<HotelCard> createState() => _HotelCardState();
}

class _HotelCardState extends State<HotelCard> {
  late bool isFavorite;
  final FavoritesRepository _favoritesRepository = FavoritesRepository();

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isFavorite;
  }

  /// Toggle favorite status and update locally and in storage
  void _toggleFavorite() async {
    try {
      if (isFavorite) {
        await _favoritesRepository.removeFavoriteHotel(widget.hotel);
      } else {
        await _favoritesRepository.saveFavoriteHotel(widget.hotel);
      }

      setState(() {
        isFavorite = !isFavorite;
      });
    } catch (e) {
      // Handle any errors
      print('Error toggling favorite: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: Column(
        children: [
          // Hotel Image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child: Image.network(
              widget.hotel.image ?? 'https://via.placeholder.com/150',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 200,
                color: Colors.grey[300],
                child: const Icon(Icons.broken_image, size: 50, color: Colors.grey),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hotel Name
                Text(
                  widget.hotel.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                // Hotel Description
                Text(
                  widget.hotel.description ?? 'No description available',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                // Price and Rating Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Price
                    Text(
                      '\$${widget.hotel.price.toStringAsFixed(2)} / night',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                      ),
                    ),
                    // Rating
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        Text(
                          widget.hotel.rating.toStringAsFixed(1),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Favorite Button
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                    ),
                    onPressed: _toggleFavorite,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
