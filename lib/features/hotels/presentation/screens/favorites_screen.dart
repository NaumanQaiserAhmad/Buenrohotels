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
          return ListView.builder(
            itemCount: favoriteHotels.length,
            itemBuilder: (context, index) {
              return HotelCard(
                hotel: favoriteHotels[index],
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
