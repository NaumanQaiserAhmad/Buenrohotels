import 'package:flutter/material.dart';
import '../../data/repositories/favorites_repository.dart';
import '../../domain/entities/hotel.dart';
import '../widgets/hotel_card.dart';


class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoritesRepository = FavoritesRepository();

    return FutureBuilder<List<Hotel>>(
      future: favoritesRepository.getFavoriteHotels(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          final favoriteHotels = snapshot.data!;
          // Log the list of favorite hotels
          for (var hotel in favoriteHotels) {
            print('Favorite Hotel: ${hotel.name}, Price: ${hotel.price}, Rating: ${hotel.rating}, Description: ${hotel.description}, Image: ${hotel.image}');
          }
          return ListView.builder(
            itemCount: favoriteHotels.length,
            itemBuilder: (context, index) {
              final hotel = favoriteHotels[index];
              print(
                  'Favorite Hotel Passed to HotelCard: Name: ${hotel.name}, Price: ${hotel.price}, Rating: ${hotel.rating}, Description: ${hotel.description}, Image: ${hotel.image}');
              return HotelCard(
                hotel: hotel,
                isFavorite: true,
              );
            },
          );
        }

        return const Center(child: Text('No favorites yet.'));
      },
    );
  }
}
