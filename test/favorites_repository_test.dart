import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hotel_booking_app/features/hotels/data/repositories/favorites_repository.dart';
import 'package:hotel_booking_app/features/hotels/domain/entities/hotel.dart';

void main() {
  late FavoritesRepository favoritesRepository;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    favoritesRepository = FavoritesRepository();
  });

  group('FavoritesRepository', () {
    const testHotel = Hotel(
      name: 'Test Hotel',
      link: 'http://example.com',
      price: 100.0,
      rating: 4.5,
      image: 'http://example.com/image.png',
      description: 'A test hotel.',
    );

    test('saveFavoriteHotel saves a hotel', () async {
      await favoritesRepository.saveFavoriteHotel(testHotel);
      final favorites = await favoritesRepository.getFavoriteHotels();

      expect(favorites.length, 1);
      expect(favorites.first.name, testHotel.name);
    });

    test('removeFavoriteHotel removes a hotel', () async {
      await favoritesRepository.saveFavoriteHotel(testHotel);
      await favoritesRepository.removeFavoriteHotel(testHotel);
      final favorites = await favoritesRepository.getFavoriteHotels();

      expect(favorites.isEmpty, true);
    });

    test('getFavoriteHotels retrieves saved hotels', () async {
      await favoritesRepository.saveFavoriteHotel(testHotel);
      final favorites = await favoritesRepository.getFavoriteHotels();

      expect(favorites.length, 1);
      expect(favorites.first.name, testHotel.name);
    });
  });
}
